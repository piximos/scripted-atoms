#!/bin/bash

echo "Sending the following message :"
echo "'$SLACK_MSG'"

if [[ -n ${SLACK_ARTIFACTS} ]]; then
  payload="{ \"text\": \"$SLACK_MSG\", \"attachments\": [{\"color\": \"$SLACK_COLOR\",\"text\": \"$SLACK_ARTIFACTS\"}]}"
else
  payload="{ \"text\": \"$SLACK_MSG\", \"attachments\": [{\"color\": \"$SLACK_COLOR\",\"text\": \"$SLACK_MSG\"}]}"
fi

echo "$payload"
curl -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-type: application/json' \
  --data "$(echo "$payload")"