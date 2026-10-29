#!/bin/bash
# Starts an Xpra server. Configure with environment variables:
#   XPRA_DISPLAY   display number         (default :100)
#   XPRA_PORT      TCP / HTML5 port       (default 14500)
#   XPRA_PASSWORD  password; empty = no authentication
#   XPRA_START     app to launch; empty = none (default xterm)
# Any extra arguments are passed straight to "xpra start".
set -e

if [ -n "$XPRA_PASSWORD" ]; then
  auth="password:value=${XPRA_PASSWORD}"
else
  auth="none"
  echo "WARNING: no XPRA_PASSWORD set, anyone who can reach port ${XPRA_PORT} can use this session" >&2
fi

args=(
  start "${XPRA_DISPLAY}"
  --bind-tcp="0.0.0.0:${XPRA_PORT}"
  --tcp-auth="${auth}"
  --html=on
  --daemon=no
  --exit-with-children=no
  --mdns=no
)
[ -n "$XPRA_START" ] && args+=(--start="${XPRA_START}")

exec xpra "${args[@]}" "$@"
