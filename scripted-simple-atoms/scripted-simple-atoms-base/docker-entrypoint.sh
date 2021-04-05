#!/bin/bash

/env-variables-checker.sh
[ $? -eq 0 ]  || exit 1

if [[ -z $RUNNER_FILE_PATH || ! -f "$RUNNER_FILE_PATH" ]]; then
  echo "Runner file not found."
  exit 1
fi

bash "$RUNNER_FILE_PATH"
[ $? -eq 0 ]  || exit 1
