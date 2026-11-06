#!/bin/sh
# Run xpra inside the server container (used as --remote-xpra)
exec docker exec -i xpra-display-server xpra "$@"
