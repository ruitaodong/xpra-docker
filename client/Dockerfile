# Xpra 5.1 LTS client for Apple Container (arm64), drawing through XQuartz on the Mac
FROM debian:bookworm

# "xpra-lts" = 5.1.x (talks to 3.1 through 6.x servers), "xpra" = current stable
ARG XPRA_CHANNEL=xpra-lts
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && curl -fsSL --retry 3 -o /usr/share/keyrings/xpra.asc https://xpra.org/xpra.asc \
 && curl -fsSL --retry 3 -o /etc/apt/sources.list.d/xpra.sources \
      "https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/bookworm/${XPRA_CHANNEL}.sources" \
 && apt-get update \
 && apt-get install -y xpra-client-gtk3 xpra-codecs dbus xauth iproute2 \
 && rm -rf /var/lib/apt/lists/* \
 && xpra --version

RUN useradd -m -u 1000 -s /bin/bash app
COPY --chmod=755 attach.sh /usr/local/bin/xpra-attach

USER app
WORKDIR /home/app
ENV XPRA_SERVER=tcp://mini:14500/ \
    XPRA_KEYBOARD_LAYOUT=us

ENTRYPOINT ["/usr/local/bin/xpra-attach"]
