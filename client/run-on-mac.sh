#!/bin/bash
# Run on the Mac. Starts the Xpra client container, drawing through XQuartz.
# Needs XQuartz running with Settings > Security >
#   "Allow connections from network clients" turned on (restart XQuartz after changing it).

IMAGE=${XPRA_CLIENT_IMAGE:-ghcr.io/ruitaodong/xpra-docker-client:latest}

exec container run --rm -it --ssh\
  -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0\
  -e DISPLAY=:0\
  --name=$(hostname)\
  "$IMAGE" "$@"

