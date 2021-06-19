#!/bin/bash

TAGS="$TAGS sa-$(git describe | grep -Eo '^([0-9]+(\-|\.)[0-9]+((\-|\.)[0-9]+)?)' | tr '-' '.')"

if [[ "${SUCCESS}" == "true" ]]; then
  DISCORD_MSG="Successfully deployed the following tags :"
else
  DISCORD_MSG="Failed to build and deploy the following tags :"
fi

for tag in ${TAGS}; do
  DISCORD_MSG="$DISCORD_MSG \\n > $IMAGE:\`$tag\`"
done

export DISCORD_MSG="$DISCORD_MSG"

./scripted-simple-atoms/pipeline-discorder-atom/runner.sh