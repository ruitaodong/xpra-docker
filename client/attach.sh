#!/bin/bash
# Runs inside the container: points X11 at XQuartz on the Mac, then attaches.
#   XPRA_SERVER           server URI          (default tcp://mini:14500/)
#   XPRA_KEYBOARD_LAYOUT  keyboard layout     (default us)
#   DISPLAY               X server; default = the Mac (container's gateway), display :0
#   X11_COOKIE            XQuartz auth cookie, passed in by run-on-mac.sh
# Extra arguments are passed to "xpra attach".
set -e

if [ -z "$DISPLAY" ]; then
  gw=$(ip route | awk '/^default/ {print $3; exit}')
  export DISPLAY="${gw:-192.168.64.1}:0"
fi

if [ -n "$X11_COOKIE" ]; then
  xauth add "$DISPLAY" MIT-MAGIC-COOKIE-1 "$X11_COOKIE"
fi

echo "Using DISPLAY=$DISPLAY, server $XPRA_SERVER" >&2

exec dbus-run-session -- xpra attach "$XPRA_SERVER" \
  --tray=no \
  --opengl=no \
  --mmap=no \
  --keyboard-layout="$XPRA_KEYBOARD_LAYOUT" \
  --encodings=h264,vp8,rgb \
  --webcam=no \
  --printing=no \
  --speaker=disabled \
  --microphone=disabled \
  --bell=no \
  --system-tray=no \
  --notifications=no \
  --clipboard=no \
  --xsettings=no \
  --file-transfer=no \
  --open-files=no \
  --remote-logging=no \
  "$@"
