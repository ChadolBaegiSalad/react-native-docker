#!/usr/bin/env bash

PROJECT_NAME='WakeupHere' # project's name
PROJECT_ROOT_DIR='/Users/shinyup/Project/ChadolBaegiSalad/WakeupHere' # your project's root directory
DOCKER_IMAGE_TAG='polaris707/react-native-docker'

# docker-machine set-up
docker-machine start
docker-machine env
eval $(docker-machine env)

docker ps -a | grep -w ${PROJECT_NAME} | awk '{print $1}' | xargs docker stop
docker ps -a | grep -w ${PROJECT_NAME} | awk '{print $1}' | xargs docker rm

docker run --privileged --net=host -h ${PROJECT_NAME} -it -d --name ${PROJECT_NAME} \
    -v /dev/bus/usb:/dev/bus/usb \
    -v ${PROJECT_ROOT_DIR}:/home/project \
    ${DOCKER_IMAGE_TAG}
