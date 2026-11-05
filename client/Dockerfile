# Xpra 5.1 LTS client for Apple Container (arm64), drawing through XQuartz on the Mac
FROM ubuntu:noble

# "xpra-lts" = 5.1.x (talks to 3.1 through 6.x servers), "xpra" = current stable
ARG XPRA_CHANNEL=xpra-lts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates

ADD --chmod=0644 https://xpra.org/xpra.asc /usr/share/keyrings/
ADD --chmod=0644 https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/noble/xpra-lts.sources /etc/apt/sources.list.d/

RUN apt-get update \
 && apt-get install -y  --no-install-recommends xpra-client-gtk3 xpra-codecs iproute2 \
 && rm -rf /var/lib/apt/lists/*


