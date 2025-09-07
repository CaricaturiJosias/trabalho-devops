#!/bin/bash

url="http://localhost:8200/"

# Send GET request (silent, no output, only status code)
status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

if [ "$status_code" -eq 200 ]; then
    echo "Service working successfully"
else
    echo "Service is not working as expected: error code $status_code"
    exit 1
fi