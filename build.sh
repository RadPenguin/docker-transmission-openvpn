#!/bin/bash

REPO_NAME=taeram/transmission-openvpn

# Get the latest tag from the transmission/transmission repo using curl and jq.
TRANSMISSION_VERSION=$(curl -s https://api.github.com/repos/transmission/transmission/tags | jq -r '.[0].name')

scriptStartTime=$( date +%s )

set -e -u

docker login
docker build \
    --build-arg TRANSMISSION_VERSION="$TRANSMISSION_VERSION" \
    --tag=$REPO_NAME .
docker push $REPO_NAME

scriptEndTime=$( date +%s )
echo "Completed build in "$((scriptEndTime-$scriptStartTime))" seconds"
