#! /bin/bash

TARGET_URL=$1

# Load test using hey
# Number of requests: 10000
# Concurrency workers: 5
# Queries per second: 50
hey -n 10000 -c 5 -q 50 $TARGET_URL