#!/bin/bash

ln -sf "$ADDITIONAL_SCRIPTS_DIR" "$SCRIPTS_DIR"

bash -c "python -u \"$RUNNER_FILE_PATH\""