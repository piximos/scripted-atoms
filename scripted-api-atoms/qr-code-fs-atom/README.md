# Scripted API Atom : QR Code Generator FS

The **QR Code Generator FS** Scripted Api Atom, generates a QR code from the values given to it through an API call and
saves it on the FS.

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

## How does it work?

Before starting your container, mount your destination folder to the one specified by the `QR_TMP_FOLDER` environment
variable.

Upon starting, the container exposes itself on the port `8420`. After which, in order to generate your QR code, run the
following API request :

```bash
curl --location --request POST 'http://<url-to-access-container>/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "id": "foo",
    "content": "bar",
    "fill_color": "#121128",
    "bg_color": "#dcdbdb"
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
  
The resulting QR code will look like this :

![The resulting image](./docs/images/foo.png)
