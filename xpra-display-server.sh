#!/bin/sh

IMAGE=ghcr.io/ruitaodong/xpra-docker-client

docker run --rm\
  --name xpra-display-server \
  --user $(id -u):$(id -g)\
  --hostname=$(hostname)\
  --device /dev/dri\
  --group-add video\
  --group-add 992\
  -v /tmp/.X11-unix:/tmp/.X11-unix\
  -v ./run-user/:/run/user/\
  -v /etc/passwd:/etc/passwd:ro\
  -v /etc/group:/etc/group:ro\
  -e XDG_RUNTIME_DIR=/run/user\
  -e HOME=/run/user/
  ${IMAGE} "$@"

