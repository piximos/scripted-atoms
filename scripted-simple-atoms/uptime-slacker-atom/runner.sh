#!/bin/bash

LAST_DETECTED_DOWNTIME="none"

send_slack_message() {
  message="${1}"
  color="${2}"
  artifacts="${3}"

  payload="{ \"text\": \"$message\", \"attachments\": [{\"color\": \"$color\",\"text\": \"$artifacts\"}]}"
  curl -s -X POST "$SLACK_WEBHOOK_URL" -H 'Content-type: application/json' --data "$payload" -o /dev/null
}

run_uptime() {
  status_code="$(curl -w '%{http_code}' -s -o /dev/null -L ${SA_WEBSITE_URL})"

  if [[ "$status_code" != "200" ]]; then
    if [[ "$LAST_DETECTED_DOWNTIME" == "none" ]]; then
      LAST_DETECTED_DOWNTIME="$(date '+%x %X %Z')"
      artifacts="Downtime detected at *${LAST_DETECTED_DOWNTIME}* \\nError code : \`$status_code\`"
      send_slack_message "${SA_WEBSITE_URL} is down!" "${SLACK_FAILURE_COLOR}" "${artifacts}"
    fi
  else
    if [[ "$LAST_DETECTED_DOWNTIME" != "none" ]]; then
      send_slack_message "${SA_WEBSITE_URL} is up!" "${SLACK_SUCCESS_COLOR}" "Downtime detected at *${LAST_DETECTED_DOWNTIME}* \\nUptime detected at *$(date '+%x %X %Z')*"
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
