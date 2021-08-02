# Scripted Simple Atoms : Pipeline Slacker

This image launches inside your pipeline to send Slack messages.

## Image pull

```bash
  docker pull scriptedatom/pipeline-slacker
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SLACK_WEBHOOK_URL`
    * Description : The slack webhook URL for messaging.
    * Required : `true`
* `SLACK_COLOR`
    * Description : The border color of the slack message.
    * Required : `true`
* `SLACK_MSG`
    * Description : The slack message to send.
    * Required : `true`
* `SLACK_ARTIFACTS`
    * Description : The slack block to send alongside the message.
    * Required : `false`
