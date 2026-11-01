# Xpra server on Ubuntu 24.04 (noble), installed from xpra.org
# (Ubuntu's own package is the outdated 3.1.5)
FROM ubuntu:24.04

# "xpra" = stable, "xpra-lts" = long-term support, "xpra-beta" = beta
ARG XPRA_CHANNEL=xpra
ENV DEBIAN_FRONTEND=noninteractive

# The repo definition comes from Xpra's GitHub repo; the signing key from xpra.org.
# curl -f makes a missing file fail loudly instead of wget's silent exit code 8.
RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && curl -fsSL --retry 3 -o /usr/share/keyrings/xpra.asc https://xpra.org/xpra.asc \
 && curl -fsSL --retry 3 -o /etc/apt/sources.list.d/xpra.sources \
      "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/noble/${XPRA_CHANNEL}.sources" \
 && cat /etc/apt/sources.list.d/xpra.sources \
 && apt-get update \
 && apt-get install -y xpra xpra-html5 xterm dbus dbus-x11 \
 && rm -rf /var/lib/apt/lists/*

# Replace the image's default "ubuntu" user (uid 1000) with an "app" user.
# (The xpra package already creates an "xpra" group, so that name is taken.)
RUN (userdel -r ubuntu 2>/dev/null || true) \
  && useradd -m -u 1000 -s /bin/bash app \
  && (getent group xpra >/dev/null && usermod -aG xpra app || true) \
  && mkdir -p /run/xpra /tmp/xpra-runtime \
  && chown app:app /tmp/xpra-runtime \
  && chmod 700 /tmp/xpra-runtime \
  && chmod 1777 /run/xpra

USER app
WORKDIR /home/app
ENV XDG_RUNTIME_DIR=/tmp/xpra-runtime

EXPOSE 14500

# Xpra needs a D-Bus session bus (its keyboard setup won't start without one),
# so every command runs under its own private bus.
# Create the runtime dir before dbus-run-session and keep the process in the foreground.
ENTRYPOINT ["/bin/bash", "-lc", "mkdir -p \"$XDG_RUNTIME_DIR\" && chmod 700 \"$XDG_RUNTIME_DIR\" && exec dbus-run-session -- xpra \"$@\"", "--"]

# Default server; any arguments after the image name replace this whole list.
CMD ["start", ":100", \
     "--bind-tcp=0.0.0.0:14500", "--tcp-auth=none", \
     "--html=on", "--daemon=no", "--exit-with-children=no", \
     "--start=xterm", \
     "--pulseaudio=no", "--speaker=off", "--microphone=off", \
     "--mdns=no", "--dbus-launch=", "--dbus-control=no", "--notifications=no"]
