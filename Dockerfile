# Xpra server on Ubuntu 24.04 (noble), installed from xpra.org
# (Ubuntu's own package is the outdated 3.1.5)
FROM ubuntu:24.04

# "xpra" = stable channel, "xpra-beta" = beta channel
ARG XPRA_CHANNEL=xpra
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates wget \
 && wget -qO /usr/share/keyrings/xpra.asc https://xpra.org/xpra.asc \
 && wget -qO /etc/apt/sources.list.d/xpra.sources \
      "https://xpra.org/repos/noble/${XPRA_CHANNEL}.sources" \
 && apt-get update \
 && apt-get install -y xpra xpra-html5 xterm dbus-x11 \
 && rm -rf /var/lib/apt/lists/*

# Replace the image's default "ubuntu" user (uid 1000) with an "xpra" user
RUN (userdel -r ubuntu 2>/dev/null || true) \
 && useradd -m -u 1000 -s /bin/bash xpra \
 && mkdir -p /run/xpra /run/user/1000 \
 && chown xpra:xpra /run/user/1000 \
 && chmod 700 /run/user/1000 \
 && chmod 1777 /run/xpra

COPY --chmod=755 entrypoint.sh /usr/local/bin/xpra-entrypoint

USER xpra
WORKDIR /home/xpra
ENV XDG_RUNTIME_DIR=/run/user/1000 \
    XPRA_DISPLAY=:100 \
    XPRA_PORT=14500 \
    XPRA_START=xterm

EXPOSE 14500
ENTRYPOINT ["/usr/local/bin/xpra-entrypoint"]
