#!/bin/bash

DOCKER_HUB_API="https://hub.docker.com/v2"
STATUS_CODE_OUTPUT_FORMAT=' { "statusCode": %{http_code}} '

process_results() {
  result=${1}
  error_msg=${2}

  output=$(echo "$result" | jq -rc 'del(.statusCode)')
  status_code=$(echo "$result" | jq -r .statusCode)

  if [[ ${status_code} == 20* ]]; then
    echo "$output"
  else
    echo "[ERROR, CODE='${status_code}'] ${error_msg}" >/dev/stderr
    echo "[ERROR_OUTPUT] ${output}" >/dev/stderr
    exit 1
  fi

}

# Authenticate with Docker hub and recover JWT token
recover_token() {
  result=$(curl -s -X POST \
    -w "${STATUS_CODE_OUTPUT_FORMAT}" \
    -H "Content-Type: application/json" \
    -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' \
    "${DOCKER_HUB_API}/users/login/" | jq -ren '[inputs] | add')

  process_results "${result}" "Failed to authenticate with Docker Hub" | jq -r .token | cat -
}

# Recovers all the namespaces of the user
get_namespaces() {
  token=${1}
  if [[ -n ${DOCKER_NAMESPACE} && "${DELETE_ACROSS_ALL_NAMESPACES}" != "true" ]]; then
    echo "${DOCKER_NAMESPACE}"
  elif [[ -z ${DOCKER_NAMESPACE} && "${DELETE_ACROSS_ALL_NAMESPACES}" != "true" ]]; then
    echo "${DOCKER_USERNAME}"
  else
    result=$(curl -s -X GET \
      -w "${STATUS_CODE_OUTPUT_FORMAT}" \
      -H "Authorization: JWT ${token}" \
      "${DOCKER_HUB_API}/repositories/namespaces/" | jq -ren '[inputs] | add')

    process_results "${result}" "Failed to get namespaces from Docker Hub" | jq -r '.namespaces|.[]' | cat -
  fi
}

# Recovers a list of repos for a specific namespace
get_all_repos() {
  if [[ -z ${DOCKER_IMAGE_NAME} ]]; then
    token=${1}
    namespace=${2}
    result=$(curl -s -X GET \
      -w "${STATUS_CODE_OUTPUT_FORMAT}" \
      -H "Authorization: JWT ${token}" \
      "${DOCKER_HUB_API}/repositories/${namespace}/?page_size=10000" | jq -ren '[inputs] | add')

    process_results "${result}" "Failed to get repos from Docker Hub" | jq -r '.results|.[]|.name' | cat -
  else
    echo "${DOCKER_IMAGE_NAME}"
  fi
}

# Recovers a list of tags for a specific image
get_tags_of_repo() {
  token=${1}
  namespace=${2}
  repo=${3}
  result=$(curl -s -X GET \
    -w "${STATUS_CODE_OUTPUT_FORMAT}" \
    -H "Authorization: JWT ${token}" \
    "${DOCKER_HUB_API}/repositories/${namespace}/${repo}/tags/?page_size=10000" | jq -ren '[inputs] | add')
  process_results "${result}" "Failed to get tags from Docker Hub" | jq -r '.results|.[]|.name' | cat -
}

# Deletes a tag from a repo
delete_tag() {
  token=${1}
  namespace=${2}
  repo=${3}
  tag=${4}
  result=$(curl -s -X DELETE \
    -w "${STATUS_CODE_OUTPUT_FORMAT}" \
    -H "Accept: application/json" -H "Authorization: JWT ${token}" \
    "${DOCKER_HUB_API}/repositories/${namespace}/${repo}/tags/${tag}/" | jq -ren '[inputs] | add')
  process_results "${result}" "Failed to delete tags from Docker Hub" > /dev/null
}

recover_token | while read -r token; do
  get_namespaces "${token}" | while read -r namespace; do
    get_all_repos "${token}" "${namespace}" | while read -r repo; do
      echo "[NAMESPACE='${namespace}'] Processing '$repo' tags"
      get_tags_of_repo "${token}" "${namespace}" "${repo}" | while read -r tag; do
        if [[ $tag == ${DOCKER_IMAGE_TAG} ]]; then
          echo "[NAMESPACE='${namespace}', REPO='${repo}'] Deleting the '$tag' tag"
          delete_tag "${token}" "${namespace}" "${repo}" "${tag}"
        fi
      done
    done
  done
done
