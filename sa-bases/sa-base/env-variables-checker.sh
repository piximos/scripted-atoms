#!/bin/bash

if [[ -z ${VALIDATE_VERBOSELY} ]]; then
  VALIDATE_VERBOSELY="false"
fi

prompt_action() {
  if [[ "$VALIDATE_VERBOSELY" == "true" ]]; then
    echo -e "${1}"
  fi
}

env_variable_value_validator() {
  values="$(echo "${1}" | jq -r '. | @sh' | tr -d \')"
  values=("$values")
  var_name="${2}"
  var_value="${!var_name}"

  if [[ ! ${values[*]} =~ ${var_value} ]]; then
    echo "The value [$var_value] of the variable '$var_name' must be on of the following : ${values[*]}"
    exit 1
  fi
}

env_variable_validator() {
  var_name="$(echo "${1}" | jq -r .name)"
  var_required="$(echo "${1}" | jq -r .required)"
  var_required_if="$(echo "${1}" | jq -r .required_if)"
  var_description="$(echo "${1}" | jq -r .desc)"
  var_values="$(echo "${1}" | jq -r .values)"

  prompt_action "\nValidating [${var_name}] :"
  prompt_action "\tRequired : $([[ ${var_required} != "null" && ${var_required} == "true" ]] && echo "true" || echo "false")"
  [[ ${var_required_if} != "null" ]] && echo -e "\tRequired when [${var_required_if}] is set"
  prompt_action "\tDescription : ${var_description}"

  if [[ $var_required == "true" && -z "${!var_name}" ]]; then
    echo "The variable '$var_name' [$var_description] is not set. "
    exit 1
  fi

  if [[ "${var_required_if}" != "null" && -n "${!var_required_if}" && -z "${!var_name}" ]]; then
    echo "The variable '$var_name' [$var_description] is required when [$var_required_if] is set. "
    exit 1
  fi

  if [[ -n "${var_values}" && "${var_values}" != "null" ]]; then
    env_variable_value_validator "$var_values" "$var_name"
  fi
  prompt_action "Validation for [${var_name}] passed!"
}

jq -c .variables[] <"$@" | while read -r variable; do
  env_variable_validator "$variable"
done
