#!/bin/bash

if [[ "${SUCCESS}" == "true" ]]; then
  SLACK_MSG="Successfully deployed the following images :"
  SLACK_COLOR="#87ebaa"
else
  SLACK_MSG="Failed to build and deploy the following images :"
  SLACK_COLOR="#eb87b7"
fi

IFS=', ' read -r -a TAGS <<<"$(echo "$TAGS")"

slack_artifacts=""
for tag in "${TAGS[@]}"; do
  slack_artifacts="$slack_artifacts\\n- $IMAGE:\`$tag\`"
done

docker pull scriptedatom/ssa-pipeline-slacker:latest
docker run --rm \
  -e SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL" \
  -e SLACK_MSG="$SLACK_MSG" \
  -e SLACK_COLOR="$SLACK_COLOR" \
  -e SLACK_ARTIFACTS="$slack_artifacts" \
  scriptedatom/ssa-pipeline-slacker:latest
