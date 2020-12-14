#!/bin/bash

if [ -f "/validators/config-validator.py" ]; then
  python /validators/config-validator.py
  ret=$?
  if [ $ret -ne 0 ]; then
    exit 1
  fi
fi

uvicorn app:atom --host 0.0.0.0 --port "$ATOM_PORT"