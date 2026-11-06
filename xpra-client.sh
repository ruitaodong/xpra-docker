#!/bin/sh
# Usage: xpra-client.sh attach tcp://mini:14500/ [more options]

unset DBUS_SESSION_BUS_ADDRESS
unset XDG_CURRENT_DESKTOP
unset XDG_SEAT
export SSH_AUTH_SOCK=/var/host-services/ssh-auth.sock

exec xpra \
  --tray=no \
  --opengl=no \
  --dbus-launch=no\
  --dbus-control=no\
  --dbus-proxy=no\
  --mdns=no \
  --notifications=no \
  --clipboard=yes \
  --pulseaudio=no \
  --speaker=disabled \
  --microphone=disabled \
  "$@"
