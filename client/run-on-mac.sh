#!/bin/bash
# Run on the Mac. Starts the Xpra client container, drawing through XQuartz.
# Needs XQuartz running with Settings > Security >
#   "Allow connections from network clients" turned on (restart XQuartz after changing it).

IMAGE=ghcr.io/ruitaodong/xpra-docker-client

exec container run --rm -it --ssh\
  -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0\
  -v /share/WIP/xpra-docker:/share/WIP/xpra-docker:ro\
  -e SSH_AUTH_SOCK=/var/host-services/ssh-auth.sock\
  -u 0:0\
  -e DISPLAY=:0\
  --name=$(hostname)\
  --entrypoint=bash\
  "$IMAGE" "$@"
