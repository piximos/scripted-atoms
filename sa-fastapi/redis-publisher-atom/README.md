# Redis Publisher API

The **Redis Publisher** Scripted Api Atom, exposes an API that publishes values inside a Redis message stream (pubsub)

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_REDIS_HOST`
    * Description : The Redis database host.
    * Required : `true`
* `SA_REDIS_PORT`
    * Description : The Redis database port.
    * Required : `true`
* `SA_REDIS_PASSWORD`
    * Description : The Redis database password.
    * Required : `false`

## How does it work?

Upon starting, the container exposes itself, by default and if the value of `ATOM_PORT` has not been changed, on
port `8420`. After which, in order to publish a message, run the following API request :

```bash
curl --location --request POST 'http://<url-to-access-container>/' \
--header 'Content-Type: application/json' \
--data-raw '{
    "channel": "test",
    "payload": {
      "hello": "world"
    }
}'
```

The JSON body of the Publisher request consists of the following values :

* `channel`
    * _Type_ : **String**
    * _Required_ : **True**
    * _Description_ : The channel to publish values into.
* `payload`
    * _Type_ : **Any**
    * _Required_ : **True**
    * _Description_ : The content of your message.
