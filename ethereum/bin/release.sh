#!/bin/sh
# Run from within ./ethereum directory

USERNAME=ld100
IMAGE=ethereum

docker build -t ${USERNAME}/${IMAGE}:alpine .
docker push ${USERNAME}/${IMAGE}:alpine
