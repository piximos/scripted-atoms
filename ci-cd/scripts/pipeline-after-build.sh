#!/bin/bash

if [[ "$SA_BETA_BUILD" == "true" ]]; then
  TAGS="$CI_COMMIT_REF_NAME-${CI_COMMIT_SHA:0:8}"
else
  PUBLIC_VERSION="$(git describe | grep -Eo '^([0-9]+(\-|\.)[0-9]+((\-|\.)[0-9]+)?)' | tr '-' '.')"
  TAGS="latest $PUBLIC_VERSION sa-$PUBLIC_VERSION"
fi

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
  slack_artifacts="$slack_artifacts\\n- $IMAGE_NAME:\`$tag\`"
  DISCORD_MSG="$DISCORD_MSG \\n > $IMAGE_NAME:\`$tag\`"
done

export SLACK_MSG="$SLACK_MSG"
export SLACK_COLOR="$SLACK_COLOR"
export SLACK_ARTIFACTS="$slack_artifacts"
export DISCORD_MSG="$DISCORD_MSG"

echo "Sending Slack Message"
./sa-bash/pipeline-slacker-atom/runner.sh
echo "Sending Discord Message"
./sa-bash/pipeline-discorder-atom/runner.sh

echo "Cleaning pipeline"
for tag in ${TAGS}; do
  echo "Deleting the following image : ${IMAGE_NAME}:${tag}"
  docker rmi "${IMAGE_NAME}:${tag}" || true
done
