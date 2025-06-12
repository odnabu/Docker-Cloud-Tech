#!/bin/bash
IMAGE_NAME="viktarveratsennikau/go-idea-server:1.0.0"
HOST_PORT="10020"
CONTAINER_PORT="8080"
echo "Launching Docker image: $IMAGE_NAME on port $HOST_PORT"
docker run -d -p $HOST_PORT:$CONTAINER_PORT --name go-idea-server-instance $IMAGE_NAME
if [ $? -ne 0 ]; then
  echo "Failed to launch Docker image."
  exit 1
fi
echo "Successfully launched $IMAGE_NAME. Access it at http://localhost:$HOST_PORT"
echo "To stop the container, run: docker stop go-idea-server-instance"
echo "To remove the container, run: docker rm go-idea-server-instance"
