# Scripted API Atom : QR Code Generator S3

The **QR Code Generator FS** Scripted Api Atom, generates a QR code from the values given to it through an API call and
saves it to an S3 bucket.

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `QR_TMP_FOLDER`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `/tmp/scripted-atom`
    * _Description_ : The path of the generated QR codes inside the container
* `SA_QR_FILL_COLOR`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `#121128`
    * _Description_ : The Hex color code for the generated QR code fill color
* `SA_QR_BACKGROUND_COLOR`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `#dcdbdb`
    * _Description_ : The Hex color code for the generated QR code background color
* `SA_BUCKET_ENDPOINT`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : The S3 bucket endpoint.
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
* `SA_BUCKET_PATH`
    * _Required_ : **True**
    * _Type_ : **String**
    * _Description_ : Root path for the QR codes to be stored under, inside the bucket.
* `SA_BUCKET_SIGN_OBJECT`
    * _Required_ : **True**
    * _Type_ : **Boolean**
    * _Description_ : Whether to return a signed URL for the generated QR code after generation or not.

## How does it work?

Upon starting, the container exposes itself on the port `8420`. After which, in order to generate your QR code, run the
following API request :

```bash
curl --location --request POST 'http://<url-to-access-container>/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "id": "foo",
    "content": "bar",
    "fill_color": "#121128",
    "bg_color": "#dcdbdb",
    "path_under_bucket": "testing/folder"
}'
```

The JSON body of the QR code creation request consists of the following values :

* `id`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The name of the generated QR code.
* `content`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The content of the QR code.
* `fill_color`
    * _Type_ : **String**
    * _Required_ : **False**
    * _Default_ : The value of the `SA_QR_FILL_COLOR` environment variable.
    * _Description_ : Custom color for the QR code fill.
* `bg_color`
    * _Type_ : **String**
    * _Required_ : **False**
    * _Default_ : The value of the `SA_QR_BACKGROUND_COLOR` environment variable.
    * _Description_ : Custom color for the QR code background.
* `path_under_bucket`
    * _Type_ : **String**
    * _Required_ : **False**
    * _Default_ : The value of the `SA_BUCKET_PATH` environment variable.
    * _Description_ : Custom root path for the QR code.

The resulting QR code will look like this :

![The resulting image](./docs/images/foo.png)
