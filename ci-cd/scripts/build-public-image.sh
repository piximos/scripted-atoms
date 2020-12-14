#!/bin/sh

set -x # echo on

sed -e "s/registry.gitlab.com\///g" -i "${DOCKER_IMAGE_PATH}"
docker build --cache-from "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
