#!/bin/bash

mc config host add atom "$S3_URI" "$S3_ACCESS_KEY" "$S3_SECRET_KEY"

copy_file_to_s3() {
  file_source=${1}
  file_destination_name=${2}
  echo "copying $file_source -> $S3_BUCKET_NAME/$(compose_folder_name)/$(basename "$file_destination_name")"
  mc cp "$file_source" "atom/$S3_BUCKET_NAME/$(compose_folder_name)/$(basename "$file_destination_name")"
}

copy_folder_to_s3() {
  folder_source=${1}
  echo "copying $folder_source -> $S3_BUCKET_NAME/$(compose_folder_name)"
  mc cp -r "$folder_source" "atom/$S3_BUCKET_NAME/$(compose_folder_name)"
}

compose_folder_name() {
  date_format="+%F"
  date_stamp="$(date "$date_format")"

  if [[ $FOLDER_ADD_TIMESTAMP == "true" ]]; then
    if [[ $FOLDER_TIMESTAMP_POSITION == "suffix" ]]; then
      echo "$DESTINATION_FOLDER-$date_stamp"
    else
      echo "$date_stamp-$DESTINATION_FOLDER"
    fi
  else
    echo "$DESTINATION_FOLDER"
  fi
}

if [[ -d $FILE_SRC ]]; then
  echo "$FILE_SRC is a directory"
  # check if folder needs to be compressed
  if [[ $ZIP_FOLDERS == "true" ]]; then
    # compressing folder
    echo "Compressing $FILE_SRC"
    destination_zip_path="/$FILE_DEST_NAME.zip"
    zip -r "$destination_zip_path" "$FILE_SRC"
    # copying compressed folder
    copy_file_to_s3 "$destination_zip_path" "$destination_zip_path"
  else
    # copying folder without compression
    echo "Skipping $FILE_SRC compression"
    copy_folder_to_s3 "$FILE_SRC"
  fi
elif [[ -f $FILE_SRC ]]; then
  # call copy file
  copy_file_to_s3 "$FILE_SRC" "$FILE_DEST_NAME"
else
  echo "$FILE_SRC is not valid path."
  exit 1
fi
