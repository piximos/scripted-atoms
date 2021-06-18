#!/bin/bash

echo "Sending the following message :"
echo "'$SLACK_MSG'"

if [[ -n ${SLACK_ARTIFACTS} ]]; then
  payload="{ \"text\": \"$SLACK_MSG\", \"attachments\": [{\"color\": \"$SLACK_COLOR\",\"text\": \"$SLACK_ARTIFACTS\"}]}"
else
  payload="{ \"text\": \"$SLACK_MSG\"}"
fi

curl -X POST "$SLACK_WEBHOOK_URL" -s -H 'Content-type: application/json' \
  -d "$payload" -o /dev/null