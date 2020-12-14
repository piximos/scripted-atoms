#!/bin/bash

if [ -f "/validators/config-validator.py" ]; then
  python /validators/config-validator.py
  ret=$?
  if [ $ret -ne 0 ]; then
    exit 1
  fi
fi

echo "Staring Scripted API Atom on port $ATOM_PORT"
uvicorn app:atom --host 0.0.0.0 --port "$ATOM_PORT"
