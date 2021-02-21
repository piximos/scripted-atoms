# Scripted API Atom : Thumbnail Generator S3

The **Thumbnail Generator FS** Scripted Api Atom, generates a thumbnail of an image that is saved on S3 and saves the 
result to a target folder on S3 as well.

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `THUMBNAIL_TMP_FOLDER`
    * _Required_ : **False**
    * _Type_ : **String**
    * _Default_ : `/tmp/scripted-atom`
    * _Description_ : The path of the generated thumbnails inside the container
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
* `SA_BUCKET_SIGN_OBJECT`
    * _Required_ : **True**
    * _Type_ : **Boolean**
    * _Description_ : Whether to return a signed URL for the generated thumbnails after generation or not.

## How does it work?

Upon starting, the container exposes itself on the port `8420`. After which, in order to generate your Thumbnails, run the
following API request :

```bash
curl --location --request POST 'http://<url-to-access-container>/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "src_image_path": "/test.jpg",
    "target_content_path": "/out",
    "target_thumbnail_sizes": [
        {
            "width": 200,
            "height": 200
        },
        ...,
        {
            "width": 800,
            "height": 800
        }
    ]
}'
```

The JSON body of the Thumbnail generator request consists of the following values :

* `src_image_path`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The path of the source image under s3
* `target_content_path`
    * _Type_ : **String**
    * _Required_ : **False**
    * _Default_ : The same directory as the source image.
    * _Description_ : The output folder of the thumbnails under s3.
* `target_thumbnail_sizes`
    * _Type_ : **List[{width:int, height:int}]**
    * _Required_ : **True**
    * _Description_ : List of target thumbnail sizes

