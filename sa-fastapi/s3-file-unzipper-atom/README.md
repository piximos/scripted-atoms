# Scripted API Atom : S3 File Unzipper

The **S3 File Unzipper** Scripted Api Atom, fetches a ZIP file from S3, unzips it, and uploads it back to S3.

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `TMP_FOLDER`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `/tmp/scripted-atom`
    * _Description_ : The path of the unzipped files inside the container
* `SA_BUCKET_ENDPOINT`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : The S3 bucket endpoint. Said URL must not contain a schema (HTTP/HTTPS)
* `SA_BUCKET_ACCESS_KEY`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Service account access key with rights on the target bucket.
* `SA_BUCKET_SECRET_KEY`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Secret key for the service account.
* `SA_BUCKET_NAME`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Target bucket

## How does it work?

Upon starting, the container exposes itself, by default and if the value of `ATOM_PORT` has not been changed, on port `8420`. After which, in order to generate your QR code, run the
following API request :

```bash
curl --location --request POST 'http://<url-to-access-container>/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "zip_file_path": "test.zip",
    "eventual_content_path": "some/folder"
}'
```

The JSON body of the QR code creation request consists of the following values :

* `zip_file_path`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The S3 path of the existing S3 file.
* `eventual_content_path`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The destination folder of the unzipped files under S3.
