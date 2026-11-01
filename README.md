# xpra-docker

Dockerized Xpra desktop environment for running a remote X11 session in a container.

This repository builds an Ubuntu 24.04 image with Xpra installed from the official Xpra package repository and configures a simple server that listens on TCP port `14500`.

## What is included

- `Dockerfile`: main Xpra server image
- `xpra-server.sh`: helper script that starts an Xpra server on display `:100`
- `xpra-client.sh`: helper script that attaches to an Xpra server
- `client/Dockerfile`: client container for connecting to a running Xpra server
- `60_server.conf`: server configuration
- `xpra.1`: Xpra man page

## Build

```bash
docker build -t xpra-docker .
```

## Run the server

```bash
docker run --rm -it \
  --name xpra-server \
  -p 14500:14500 \
  xpra-docker
```

The container starts an Xpra server on `:100` and exposes the Xpra TCP port at `14500`.

## Connect from a client

From a machine with `xpra` installed:

```bash
xpra attach tcp://<host>:14500/
```

Or use the included client helper:

```bash
./xpra-client.sh tcp://<host>:14500/
```

## Client container

A lightweight client image is also available in the `client` directory:

```bash
docker build -t xpra-client ./client
```

Then run it against the server:

```bash
docker run --rm -it --network host xpra-client
```

## Notes

- Server access is intentionally configured with `--tcp-auth=none` for easy local testing.
- The image runs as a non-root `app` user.
- Xpra is installed from `xpra.org`, not the Ubuntu package archive, to get a more recent version.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
