# Scripted Simple Atoms : Uptime Slacker

This image pings a website and sends a Slack message when a downtime is detected.

## Image pull

```bash
  docker pull scriptedatom/uptime-slacker
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_WEBSITE_URL`
    * Description : The URL of the website to check for uptime.
    * Required : `true`
* `SLACK_WEBHOOK_URL`
    * Description : The slack webhook URL for messaging.
    * Required : `true`
* `SLACK_SUCCESS_COLOR`
    * Description : The border color of the slack message on success.
    * Required : `true`
* `SLACK_FAILURE_COLOR`
    * Description : The border color of the slack message on failure.
    * Required : `true`
* `SA_IS_SLEEPER_SCRIPT`
    * Description : If set to 'false', the script executes a single time and dies. Otherwise it runs in a loop.
    * Required : `false`
    * Acceptable Values : `true` | `false`
    * Default : `true`
* `SA_SLEEP_DURATION`
    * Description : The sleep duration between uptime checks.
    * Required : `false`
    * Default : `60`
