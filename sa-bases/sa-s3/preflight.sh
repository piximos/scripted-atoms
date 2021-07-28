#!/bin/bash

mc config host add "$S3_CLIENT_PREFIX" "$S3_URI" "$S3_ACCESS_KEY" "$S3_SECRET_KEY"

bash -c "$@"