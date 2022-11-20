#!/bin/sh

USERNAME=antonpegov
IMAGE=zeropool-e2e

docker build -t $USERNAME/$IMAGE:latest . && \
docker push $USERNAME/$IMAGE:latest