#!/bin/bash

TAGS="$TAGS sa-$(git describe | grep -Eo '^([0-9]+(\-|\.)[0-9]+((\-|\.)[0-9]+)?)' | tr '-' '.')"

if [[ "${SUCCESS}" == "true" ]]; then
  SLACK_MSG="Successfully deployed the following images :"
  SLACK_COLOR="#87ebaa"
else
  SLACK_MSG="Failed to build and deploy the following images :"
  SLACK_COLOR="#eb87b7"
fi

slack_artifacts=""
for tag in ${TAGS}; do
  slack_artifacts="$slack_artifacts\\n- $IMAGE:\`$tag\`"
done

export SLACK_MSG="$SLACK_MSG"
export SLACK_COLOR="$SLACK_COLOR"
export SLACK_ARTIFACTS="$slack_artifacts"

./scripted-simple-atoms/pipeline-slacker-atom/runner.sh