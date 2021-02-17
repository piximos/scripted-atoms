#!/bin/sh

set -x # echo on

docker pull "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}"
docker tag "${CI_REGISTRY}/${SRC_IMAGE_NAME}:${IMG_TAG}" "${IMAGE_NAME}:${IMG_TAG}"
docker rmi "${IMAGE_NAME}:${IMG_TAG}"