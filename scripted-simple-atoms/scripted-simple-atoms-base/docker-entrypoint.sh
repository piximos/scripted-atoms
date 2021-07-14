#!/bin/bash

/env-variables-checker.sh
[ $? -eq 0 ] || exit 1

if [[ -z $RUNNER_FILE_PATH || ! -f "$RUNNER_FILE_PATH" ]]; then
  echo "Runner file not found. Please add your script under the following path : $RUNNER_FILE_PATH"
  echo "In case you have copied your main script under a different path, set the 'RUNNER_FILE_PATH' environment variables with its path."
  exit 1
fi

bash "$RUNNER_FILE_PATH"
[ $? -eq 0 ] || exit 1
