#!/bin/sh
# Run from within ./tendermint directory

USERNAME=ld100
IMAGE=tendermint

docker build -t ${USERNAME}/${IMAGE}:alpine .
docker push ${USERNAME}/${IMAGE}:alpine
