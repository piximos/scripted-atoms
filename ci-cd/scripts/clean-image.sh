#!/bin/bash

set -x # echo on

docker pull "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}"
docker tag "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}" "${IMAGE_NAME}:${IMG_TAG}"
docker rmi "${IMAGE_NAME}:${IMG_TAG}"
version="$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"
docker rmi "${DOCKER_REGISTRY}/${IMAGE_NAME}:${version}" 2>/dev/null