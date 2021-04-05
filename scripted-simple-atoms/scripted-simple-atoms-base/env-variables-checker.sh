#!/bin/bash

env_variable_validator() {
  var_name="$(echo "${1}" | jq -r .name)"
  var_required="$(echo "${1}" | jq -r .required)"
  var_description="$(echo "${1}" | jq -r .desc)"
  if [[ $var_required == "true" && -z "${!var_name}" ]]; then
    echo "The variable '$var_name' [$var_description] is not set. "
    exit 1
  fi
}

jq -c .variables[] <"$ENV_TEMPLATE_PATH" | while read -r variable; do
  env_variable_validator "$variable"
done