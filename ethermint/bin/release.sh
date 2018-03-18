#!/bin/sh
# Run from within ./ethermint directory

USERNAME=ld100
IMAGE=ethermint

docker build -t ${USERNAME}/${IMAGE}:alpine .
docker push ${USERNAME}/${IMAGE}:alpine
