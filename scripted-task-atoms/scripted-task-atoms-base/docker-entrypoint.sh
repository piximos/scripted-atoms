#!/bin/bash

python /base-config-validator.py

if [ -f "/validators/config-validator.py" ]; then
  python /validators/config-validator.py
  ret=$?
  if [ $ret -ne 0 ]; then
    exit 1
  fi
fi

python -u /scripted-atom/app.py