#!/bin/bash

#IMAGE_NAME="viktarveratsennikau/go-idea-server:1.0.0"
IMAGE_NAME="viktarveratsennikau/go-idea-server:1.0.0"
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .
if [ $? -ne 0 ]; then
  echo "Docker build failed."
  exit 1
fi
echo "Pushing Docker image: $IMAGE_NAME to registry"
docker push $IMAGE_NAME
if [ $? -ne 0 ]; then
  echo "Docker push failed."
  exit 1
fi
echo "Successfully pushed $IMAGE_NAME to Docker registry."
