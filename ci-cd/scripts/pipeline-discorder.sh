#!/bin/bash

TAGS="$TAGS $(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"

if [[ "${SUCCESS}" == "true" ]]; then
  DISCORD_MSG="Successfully deployed the following tags :"
else
  DISCORD_MSG="Failed to build and deploy the following tags :"
fi

for tag in ${TAGS}; do
  DISCORD_MSG="$DISCORD_MSG \\n > $IMAGE:\`$tag\`"
done

docker pull scriptedatom/ssa-pipeline-discorder:latest
docker run --rm \
  -e DISCORD_WEBHOOK_URL="$DISCORD_WEBHOOK_URL" \
  -e DISCORD_MSG="$DISCORD_MSG" \
  scriptedatom/ssa-pipeline-discorder:latest
