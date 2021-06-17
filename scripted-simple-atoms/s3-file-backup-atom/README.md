# Scripted Simple Atoms : Git Mirror

This image mirrors a repository to another remote location.

## Image pull

```bash
  docker pull scriptedatom/ssa-git-mirror
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `S3_URI`
    * Description : URL for the s3 storage.
    * Required : `true`
* `S3_ACCESS_KEY`
    * Description : Access key for the S3 storage.
    * Required : `true`
* `S3_SECRET_KEY`
    * Description : Secret Key for the S3 storage.
    * Required : `true`
* `S3_BUCKET_NAME`
    * Description : The name of the S3 bucket.
    * Required : `true`
* `ZIP_FOLDERS`
    * Description : Whether or not to compress folders and upload them as a single ZIP file.
    * Required : `false`
    * Acceptable Values : `true` | `false`
* `FILE_SRC`
    * Description : File source under container volume mount.
    * Required : `true`
* `DESTINATION_FOLDER`
    * Description : File destination folder under s3 bucket
    * Required : `true`
* `FILE_DEST_NAME`
    * Description : File name under s3 bucket
    * Required : `true`
* `FOLDER_ADD_TIMESTAMP`
    * Description : Whether or not to add a timestamp to the filename
    * Required : `true`
    * Acceptable Values : `true` | `false`
* `FOLDER_TIMESTAMP_POSITION`
    * Description : Whether to add the timestamp as 'prefix' or a 'suffix'
    * Required : `true`
    * Acceptable Values : `prefix` | `suffix`
