#!/bin/bash

set -x # echo on

if [[ $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME")
else
  IMG_TAGS=("latest" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')")
fi

for IMG_TAG in "${IMG_TAGS[@]}"; do
  echo "Building image : ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  docker build --cache-from "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
  docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  echo "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" >>./output.txt
done
