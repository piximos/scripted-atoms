#!/bin/bash

TAGS="$TAGS sa-$(git describe | grep -Eo '^([0-9]+(\-|\.)[0-9]+((\-|\.)[0-9]+)?)' | tr '-' '.')"

if [[ "${SUCCESS}" == "true" ]]; then
  SLACK_MSG="Successfully deployed the following images :"
  SLACK_COLOR="#87ebaa"
  DISCORD_MSG="Successfully deployed the following tags :"
else
  SLACK_MSG="Failed to build and deploy the following images :"
  SLACK_COLOR="#eb87b7"
  DISCORD_MSG="Failed to build and deploy the following tags :"
fi

slack_artifacts=""
for tag in ${TAGS}; do
  slack_artifacts="$slack_artifacts\\n- $IMAGE:\`$tag\`"
  DISCORD_MSG="$DISCORD_MSG \\n > $IMAGE:\`$tag\`"
done

export SLACK_MSG="$SLACK_MSG"
export SLACK_COLOR="$SLACK_COLOR"
export SLACK_ARTIFACTS="$slack_artifacts"
export DISCORD_MSG="$DISCORD_MSG"

echo "Sending Slack Message"
./scripted-simple-atoms/pipeline-slacker-atom/runner.sh
echo "Sending Discord Message"
./scripted-simple-atoms/pipeline-discorder-atom/runner.sh

echo "Cleaning pipeline"
for tag in ${TAGS}; do
  echo "Deleting the following image : ${IMAGE}:${tag}"
  docker rmi "${IMAGE}:${tag}" || true
done