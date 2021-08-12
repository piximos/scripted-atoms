#!/bin/bash

if [[ -z ${SA_BETA_BUILD} ]]; then
  SA_BETA_BUILD="false"
fi

build_image() {
  img_tag="${1}"
  echo "Building '${img_tag}' tag."
  DOCKER_BUILDKIT=1 docker build \
    --build-arg SA_BASE_VERSION="${img_tag}" \
    -t "${IMAGE_NAME}:${img_tag}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
}

re_tag_image() {
  src_tag="${1}"
  dst_tag="${2}"
  echo "Tagging '${dst_tag}' from '${src_tag}'."
  docker tag \
    "${IMAGE_NAME}:${src_tag}" \
    "${IMAGE_NAME}:${dst_tag}"
}

push_image() {
  img_tag="${1}"
  echo "Pushing '${img_tag}' tag."
  docker push "${IMAGE_NAME}:${img_tag}"
  echo "Pushed public image : ${IMAGE_NAME}"
}
PUBLIC_VERSION="$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"
REPO_VERSION="sa-$PUBLIC_VERSION"

if [[ "$SA_BETA_BUILD" == "true" ]]; then
  REPO_VERSION="$CI_COMMIT_REF_NAME-${CI_COMMIT_SHA:0:8}"
fi

build_image "${REPO_VERSION}"
push_image "${REPO_VERSION}"

if [[ "$SA_BETA_BUILD" != "true" ]]; then
  build_image "${PUBLIC_VERSION}"
  push_image "${PUBLIC_VERSION}"

  re_tag_image "${PUBLIC_VERSION}" "latest"
  push_image "latest"
fi

export SUCCESS="true"
[ $? -eq 0 ] || export SUCCESS="false"
./ci-cd/scripts/pipeline-after-build.sh

if [[ "$SA_BETA_BUILD" != "true" ]]; then
  export DOCKER_USERNAME="${DOCKER_REGISTRY_USER}"
  export DOCKER_PASSWORD="${DOCKER_REGISTRY_PASSWORD}"
  export DOCKER_IMAGE_NAME="${IMAGE_NAME}"
  export README_FILE_PATH="${DOCKER_IMAGE_PATH//Dockerfile/README.md}"
  export EXIT_GRACEFULLY="true"

  ./sa-bash/docker-hub-image-describer-atom/runner.sh
fi
