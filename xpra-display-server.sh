docker run --rm \
  --name xpra-display-server \
  --hostname=$(hostname)\
  --device /dev/dri\
  --group-add video\
  --group-add 992\
  -p 14500:14500\
  -v /tmp/.X11-unix:/tmp/.X11-unix\
  -v ./run-user/:/run/user/\
  -e HOME=/run/user/\
  --entrypoint xpra\
  ghcr.io/ruitaodong/xpra-docker\
    start :100\
    --bind-tcp=0.0.0.0:14500\
    --tcp-auth=none\
    --html=on\
    --daemon=no\
    --exit-with-children=no\
    --pulseaudio=no\
    --speaker=off\
    --microphone=off\
    --mdns=no\
    --dbus=no\
    --dbus-launch=no\
    --dbus-control=no\
    --notifications=no
