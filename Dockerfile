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
 && apt-get install -y xpra xpra-html5 xterm dbus-x11 \
 && rm -rf /var/lib/apt/lists/*

# Replace the image's default "ubuntu" user (uid 1000) with an "app" user.
# (The xpra package already creates an "xpra" group, so that name is taken.)
RUN (userdel -r ubuntu 2>/dev/null || true) \
 && useradd -m -u 1000 -s /bin/bash app \
 && (getent group xpra >/dev/null && usermod -aG xpra app || true) \
 && mkdir -p /run/xpra /run/user/1000 \
 && chown app:app /run/user/1000 \
 && chmod 700 /run/user/1000 \
 && chmod 1777 /run/xpra

USER app
WORKDIR /home/app
ENV XDG_RUNTIME_DIR=/run/user/1000 \
    XPRA_DISPLAY=:100 \
    XPRA_PORT=14500 \
    XPRA_START=xterm

EXPOSE 14500
