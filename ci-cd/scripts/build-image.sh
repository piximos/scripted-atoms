#!/bin/bash

set -x # echo on

docker build --cache-from "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
  -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
  -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
echo "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" >> ./output.txt

if [[ $BUILD_VERSION && $BUILD_VERSION == "true" ]]; then
  version="$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"
  docker build --cache-from "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${version}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
  docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${version}"
  echo "${DOCKER_REGISTRY}/${IMAGE_NAME}:${version}" >> ./output.txt
fi
