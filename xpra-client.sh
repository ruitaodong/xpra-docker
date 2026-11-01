#!/bin/sh
# Usage: xpra-client.sh attach tcp://mini:14500/ [more options]

unset DBUS_SESSION_BUS_ADDRESS
unset XDG_CURRENT_DESKTOP
unset XDG_SEAT

exec xpra \
  --tray=no \
  --opengl=no \
  --mdns=no \
  --dbus-launch=no \
  --notifications=no \
  --clipboard=no \
  --pulseaudio=no \
  --speaker=disabled \
  --microphone=disabled \
  --encodings=h264,vp8,rgb \
  "$@"
