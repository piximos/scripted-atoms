#!/bin/bash

if [[ -n "$BASE_ENV_VARIABLES" && -f "$BASE_ENV_VARIABLES" ]]; then
  /env-variables-checker.sh "$BASE_ENV_VARIABLES"
  [ $? -eq 0 ] || exit 1
fi

if [[ -n "$VALIDATE_ENV_VARIABLES" && "$VALIDATE_ENV_VARIABLES" == "true" ]]; then
  /env-variables-checker.sh "$ENV_TEMPLATE_PATH"
  [ $? -eq 0 ] || exit 1
else
  echo "Skipping env variables validation"
fi

if [[ -z $RUNNER_FILE_PATH || ! -f "$RUNNER_FILE_PATH" ]]; then
  echo "Main file not found. Please add your script under the following path : $RUNNER_FILE_PATH"
  echo "In case you have copied your main script under a different path, set the 'RUNNER_FILE_PATH' environment variables with its path."
  exit 1
fi

bash -c "$@"
