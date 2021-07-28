# Scripted Simple Atoms : Uptime Discorder

This image pings a website and sends a Discord message when a downtime is detected.

## Image pull

```bash
  docker pull scriptedatom/ssa-uptime-discorder
```

## Image configurations

In order for the image to run, you need to specify the following environment variables :

* `SA_WEBSITE_URL`
    * Description : The URL of the website to check for uptime.
    * Required : `true`
* `DISCORD_WEBHOOK_URL`
    * Description : The discord webhook URL for messaging.
    * Required : `true`
* `DISCORD_SUCCESS_EMOJI`
    * Description : The emoji to add to the discord message on success.
    * Required : `true`
* `DISCORD_FAILURE_EMOJI`
    * Description : The emoji to add to the discord message on failure.
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
