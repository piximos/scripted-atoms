#!/bin/bash

LAST_DETECTED_DOWNTIME="none"

send_discord_message() {
  message="${1}"

  payload="{ \"content\": \"$message\"}"
  curl -s -X POST "$DISCORD_WEBHOOK_URL" -H 'Content-type: application/json' --data "$payload" -o /dev/null
}

run_uptime() {
  status_code="$(curl -w '%{http_code}' -s -o /dev/null -L ${SA_WEBSITE_URL})"

  if [[ "$status_code" != "200" ]]; then
    if [[ "$LAST_DETECTED_DOWNTIME" == "none" ]]; then
      LAST_DETECTED_DOWNTIME="$(date '+%x %X %Z')"
      message="${DISCORD_FAILURE_EMOJI} ${SA_WEBSITE_URL} is down! \\n > Downtime detected at *${LAST_DETECTED_DOWNTIME}* \\n > Error code : \`$status_code\`"
      send_discord_message "$message"
    fi
  else
    if [[ "$LAST_DETECTED_DOWNTIME" != "none" ]]; then
      message="${DISCORD_SUCCESS_EMOJI} ${SA_WEBSITE_URL} is up! \\n > Downtime detected at *${LAST_DETECTED_DOWNTIME}* \\n > Uptime detected at *$(date '+%x %X %Z')*"
      send_discord_message "$message"
      LAST_DETECTED_DOWNTIME="none"
    else
      echo "${SA_WEBSITE_URL} is up."
    fi
  fi
}

if [[ "$SA_IS_SLEEPER_SCRIPT" == "true" ]]; then
  while true; do
    run_uptime
    sleep "$SA_SLEEP_DURATION"
  done
else
  run_uptime
  exit 0
fi
