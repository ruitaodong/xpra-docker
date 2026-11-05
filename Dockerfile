# Xpra server on Ubuntu 24.04 (noble), installed from xpra.org
# (Ubuntu's own package is the outdated 3.1.5)
FROM ubuntu:24.04

# "xpra" = stable, "xpra-lts" = long-term support, "xpra-beta" = beta
ARG XPRA_CHANNEL=xpra-lts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates

ADD --chmod=0644 https://xpra.org/xpra.asc /usr/share/keyrings/
ADD --chmod=0644 https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/noble/${XPRA_CHANNEL}.sources /etc/apt/sources.list.d/

# xpra-x11 (the X11 bindings) and xauth are only "recommended" by xpra-server,
# but the X11 server cannot start without them
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      xpra xpra-x11 xpra-html5 xauth xterm xfonts-75dpi \
 && rm -rf /var/lib/apt/lists/*
