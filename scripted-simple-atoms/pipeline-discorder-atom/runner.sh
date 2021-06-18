#!/bin/bash

echo "Sending the following message :"
echo "'$DISCORD_MSG'"

if [[ -n ${DISCORD_BUTTON_LABEL} && -n ${DISCORD_BUTTON_URL} ]]; then
  payload="{ \"text\": \"$DISCORD_MSG\", \"components\": [{\"type\": 1,\"components\": [{\"type\": 2,\"label\": \"$DISCORD_BUTTON_LABEL\",\"style\": 5,\"url\": \"$DISCORD_BUTTON_URL\"}]}]}"
else
  payload="{ \"content\": \"$DISCORD_MSG\"}"
fi

curl -X POST "$DISCORD_WEBHOOK_URL" \
  -H 'Content-type: application/json' \
  --data "$payload" \
  -w '%{http_code}'
