#!/bin/bash

harbor_api="$SA_HARBOR_SCHEMA://$SA_HARBOR_URI/api/v2.0"

delete_artifact() {
  echo "Deleting artifact with digest ${1}"
  curl -s -u "$SA_HARBOR_USER:$SA_HARBOR_PASSWORD" \
    -X DELETE "$harbor_api/projects/$SA_HARBOR_PROJECT/repositories/$SA_HARBOR_REPOSITORY/artifacts/$(echo "${1}" | tr -d '"')"
}

get_data() {
  page_size="20"
  page_number="${1}"
  data="$(curl -s -u "$SA_HARBOR_USER:$SA_HARBOR_PASSWORD" -X GET "$harbor_api/projects/$SA_HARBOR_PROJECT/repositories/$SA_HARBOR_REPOSITORY/artifacts?page_size=$page_size&page=$page_number")"
  echo "$data"
}

CALLED_PAGE_NUMBER="1"
KEEP_CALLING_API="true"

while [[ "$KEEP_CALLING_API" == "true" ]]; do
  # Fetch data from harbor
  echo "Calling page number $page_number"
  recovered_data="$(get_data "$CALLED_PAGE_NUMBER")"
  recovered_data_length="$(echo "$recovered_data" | jq '. | length')"
  echo "Recovered data length : $recovered_data_length"

  if [[ "$recovered_data_length" != "0" ]]; then
    # When returned data contains values
    CALLED_PAGE_NUMBER=$((CALLED_PAGE_NUMBER + 1))

    echo "$recovered_data" | jq -c '.[]' | while read -r artifact; do
      # Extract the image digest
      artifact_digest="$(echo "$artifact" | jq -c '.digest')"
      # Extract the number of tags associated to that image
      number_of_associated_tags="$(echo "$artifact" | jq -r '.tags' | jq length)"

      if [[ ! "$(echo "$artifact" | jq -c '.tags[]?')" ]]; then
        if [[ "$SA_DELETE_UNTAGGED_ARTIFACTS" == "true" ]]; then
          delete_artifact "$artifact_digest"
        fi
      else
        echo "$artifact" | jq -c '.tags[]?' | while read -r tags; do
          tag="$(echo "$tags" | jq -r '.name')"
          if [[ "$tag" == "$SA_TAG_TO_DELETE" ]]; then
            echo "Deleting the following tag : $tag"
            curl -s -u "$SA_HARBOR_USER:$SA_HARBOR_PASSWORD" \
              -X DELETE "$harbor_api/projects/$SA_HARBOR_PROJECT/repositories/$SA_HARBOR_REPOSITORY/artifacts/$(echo "$artifact_digest" | tr -d '"')/tags/$tag"
            # If only the deleted tag is associated to the image, delete the orphaned digest after tag deletion
            if [ "$number_of_associated_tags" -lt 2 ]; then
              delete_artifact "$artifact_digest"
            fi
          fi
        done
      fi
    done

  else
    # When returned data is an empty array
    KEEP_CALLING_API="false"
    echo "Exiting due to end of page."
    exit 0
  fi
done
