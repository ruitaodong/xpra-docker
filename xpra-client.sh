#!/bin/sh

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
  --webcam=no \
  --printing=no \
  --pulseaudio=no \
  --bell=no \
  --speaker=disabled \
  --microphone=disabled \
  --ssh="ssh -A -o StrictHostKeyChecking=accept-new"\
  "$@"
