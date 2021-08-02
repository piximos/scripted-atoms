# Python Redis Subscriber

This image subscribes to a Redis channel and performs an operation upon receiving a new message.

## Image pull

```bash
  docker pull scriptedatom/redis-subscriber:latest
```

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
* `SA_REDIS_CHANNEL`
    * Description : The Redis channel to subscribe to.
    * Required : `true`

Additionally, you need to provide a python script called `runner.py` and copy it under `ADDITIONAL_SCRIPTS_DIR`. By
default, `ADDITIONAL_SCRIPTS_DIR` takes the following value : `/scripts`. If you ever need to change that, you can
change the `ADDITIONAL_SCRIPTS_DIR` variable with the path to your scripts. The `runner.py` needs to have the following
structure :

```python
class Runner:
    def exec(self, data):
        # your code goes here
        pass
```