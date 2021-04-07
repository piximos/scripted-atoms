#!/bin/bash

echo "Sending the following message :"
echo "'$SLACK_MSG'"

payload="{ \"attachments\": [{\"color\": \"$SLACK_COLOR\",\"text\": \"$SLACK_MSG\"}]}"
echo "$payload"
curl -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-type: application/json' \
  --data "$(echo "$payload")"