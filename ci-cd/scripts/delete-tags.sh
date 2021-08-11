#!/bin/bash

export DOCKER_USERNAME="${DOCKER_REGISTRY_USER}"
export DOCKER_PASSWORD="${DOCKER_REGISTRY_PASSWORD}"
export DELETE_ACROSS_ALL_NAMESPACES="false"
export DOCKER_NAMESPACE="scriptedatom"
export DOCKER_IMAGE_TAG="$CI_COMMIT_REF_NAME-${CI_COMMIT_SHA:0:8}*"

echo "Deleting [TAG=${DOCKER_IMAGE_TAG}] from [NAMESPACE=${DOCKER_NAMESPACE}]"

./sa-bash/docker-hub-image-cleaner-atom/runner.sh
