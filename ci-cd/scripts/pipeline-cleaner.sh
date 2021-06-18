#!/bin/bash

TAGS="$TAGS $(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"
for tag in ${TAGS}; do
  echo "Deleting the following image : ${IMAGE}:${tag}"
  docker rmi "${IMAGE}:${tag}" || true
done
