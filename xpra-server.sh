#!/bin/sh

unset DBUS_SESSION_BUS_ADDRESS

unset XDG_CURRENT_DESKTOP

unset XDG_SEAT

exec xpra start :100\
  --start=xterm\
  --bind-tcp=0.0.0.0:14500\
  --tcp-auth=none\
  --daemon=no\
  --mdns=no\
  --dbus-launch=no \
  --dbus-proxy=no \
  --webcam=no \
  --printing=no \
  --pulseaudio=no \
  --speaker=disabled \
  --microphone=disabled \
  --bell=no \
  --system-tray=no \
  --notifications=no \
  --clipboard=no \
  --xsettings=no \
  --file-transfer=no \
  --open-files=no \
  --forward-xdg-open=no \
  --start-new-commands=no \
  --remote-logging=no \
  --sharing=no \
  --av-sync=no \
  --video-encoders=vpx,x264 $@
