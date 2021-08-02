# Scripted Simple Atoms : Pipeline Discorder

This image launches inside your pipeline to send Discord messages.

## Image pull

```bash
  docker pull scriptedatom/pipeline-discorder
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `DISCORD_WEBHOOK_URL`
    * Description : The discord webhook URL for messaging.
    * Required : `true`
* `DISCORD_MSG`
    * Description : The discord message to send.
    * Required : `true`
* `DISCORD_BUTTON_LABEL`
    * Description : The label of the button to add in the components block.
    * Required : `true`
* `DISCORD_BUTTON_URL`
    * Description : The url of the button to add in the components block.
    * Required : `false`
