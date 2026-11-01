#!/bin/bash
# Run on the Mac. Starts the Xpra client container, drawing through XQuartz.
# Needs XQuartz running with Settings > Security >
#   "Allow connections from network clients" turned on (restart XQuartz after changing it).
#
#   ./run-on-mac.sh            use the published image (pulled on first run)
#   ./run-on-mac.sh --update   pull the newest published image first
#   ./run-on-mac.sh --build    build the image locally from this folder instead
# Any other arguments are passed to "xpra attach".
set -e
cd "$(dirname "$0")"

IMAGE=${XPRA_CLIENT_IMAGE:-ghcr.io/ruitaodong/xpra-docker-client:latest}
XAUTH=/opt/X11/bin/xauth

container system start >/dev/null 2>&1 || true

case "$1" in
  --build)
    shift
    IMAGE=xpra-client:local
    container build -t "$IMAGE" .
    ;;
  --update)
    shift
    container image pull "$IMAGE"
    ;;
  *)
    if ! container image list 2>/dev/null | grep -q "${IMAGE%%:*}"; then
      container image pull "$IMAGE"
    fi
    ;;
esac

# Hand the XQuartz cookie to the container so it can draw without "xhost +"
cookie=$(DISPLAY=:0 "$XAUTH" list 2>/dev/null | awk '$2=="MIT-MAGIC-COOKIE-1" {print $3; exit}')
if [ -z "$cookie" ]; then
  echo "No XQuartz cookie found; is XQuartz running?" >&2
  exit 1
fi

exec container run --rm -it \
  -e X11_COOKIE="$cookie" \
  ${XPRA_SERVER:+-e XPRA_SERVER="$XPRA_SERVER"} \
  "$IMAGE" "$@"
