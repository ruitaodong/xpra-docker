# Xpra server on Ubuntu 24.04 (noble), installed from xpra.org
# (Ubuntu's own package is the outdated 3.1.5)
FROM ubuntu:24.04

# "xpra" = stable, "xpra-lts" = long-term support, "xpra-beta" = beta
ARG XPRA_CHANNEL=xpra
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates

ADD --chmod=0644 https://xpra.org/xpra.asc /usr/share/keyrings/
ADD --chmod=0644 https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/noble/xpra-lts.sources /etc/apt/sources.list.d/

# The repo definition comes from Xpra's GitHub repo; the signing key from xpra.org.
# curl -f makes a missing file fail loudly instead of wget's silent exit code 8.
RUN apt-get update \
 && apt-get install -y --no-install-recommends xpra xpra-html5 xterm xfonts-75dpi\
 && rm -rf /var/lib/apt/lists/*



