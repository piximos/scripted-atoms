#!/bin/bash

DOCKER_HUB_API="https://hub.docker.com/v2"
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' "${DOCKER_HUB_API}/users/login/" | jq -r .token)

# Recovers all the namespaces of the user
get_namespaces() {
  if [[ -n ${DOCKER_NAMESPACE} ]]; then
    echo "${DOCKER_NAMESPACE}"
  elif [[ -z ${DOCKER_NAMESPACE} && "${DELETE_ACROSS_ALL_NAMESPACES}" != "true" ]]; then
    echo "${DOCKER_USERNAME}"
  else
    curl -s -H "Authorization: JWT ${TOKEN}" "${DOCKER_HUB_API}/repositories/namespaces/" | jq -r '.namespaces|.[]' | cat -
  fi
}

# Recovers a list of repos for a specific namespace
get_all_repos() {
  if [[ -z ${DOCKER_IMAGE_NAME} ]]; then
    namespace=${1}
    curl -s -H "Authorization: JWT ${TOKEN}" "${DOCKER_HUB_API}/repositories/${namespace}/?page_size=10000" | jq -r '.results|.[]|.name' | cat -
  else
    echo "${DOCKER_IMAGE_NAME}"
  fi
}

# Recovers a list of tags for a specific image
get_tags_of_repo() {
  namespace=${1}
  repo=${2}
  curl -s -H "Authorization: JWT ${TOKEN}" "${DOCKER_HUB_API}/repositories/${namespace}/${repo}/tags/?page_size=10000" | jq -r '.results|.[]|.name' | cat -
}

# Deletes a tag from a repo
delete_tag() {
  namespace=${1}
  repo=${2}
  tag=${3}
  curl -s -X DELETE -H "Accept: application/json" -H "Authorization: JWT ${TOKEN}" "${DOCKER_HUB_API}/repositories/${namespace}/${repo}/tags/${tag}/"
}

NAMESPACE_LIST=$(get_namespaces)

for namespace in ${NAMESPACE_LIST}; do
  REPO_LIST=$(get_all_repos "${namespace}")
  for repo in ${REPO_LIST}; do
    IMAGE_TAGS="$(get_tags_of_repo "${namespace}" "${repo}")"

    echo "[NAMESPACE='${namespace}'] Processing '$repo' tags"
    for tag in ${IMAGE_TAGS}; do
      if [[ $tag == ${DOCKER_IMAGE_TAG} ]]; then
        echo "[NAMESPACE='${namespace}', REPO='${repo}'] Deleting the '$tag' tag"
        delete_tag "${namespace}" "${repo}" "${tag}"
      fi
    done
  done
done
