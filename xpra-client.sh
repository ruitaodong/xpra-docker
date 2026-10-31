#!/bin/sh

unset DBUS_SESSION_BUS_ADDRESS

unset XDG_CURRENT_DESKTOP

unset XDG_SEAT

exec xpra\
  --tray=no\
  --opengl=no \
  --mdns=no\
  --dbus-launch=no \
  --notifications=no \
  --opengl=no \
  --clipboard=no \
  --pulseaudio=no \
  --speaker=no \
  --microphone=no \
  --encodings=vpx,x264\
  "$@"    
