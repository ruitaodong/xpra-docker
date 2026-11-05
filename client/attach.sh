#!/bin/sh

exec xpra\
  --tray=no\
  --opengl=no\
  --mmap=no\
  --webcam=no\
  --printing=no\
  --speaker=disabled\
  --microphone=disabled\
  --bell=no\
  --system-tray=no\
  --notifications=no\
  --clipboard=yes\
  --xsettings=no\
  --file-transfer=no\
  --open-files=no\
  --remote-logging=no\
  attach "$@"
