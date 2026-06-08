#!/bin/bash
# Map the standard dynamic PORT environment variable (used by Render, Railway, etc.)
# to BIND_PORT (used by Suwayomi-Server).
if [ -n "$PORT" ]; then
  echo "Dynamic PORT detected: $PORT. Mapping to BIND_PORT."
  export BIND_PORT=$PORT
else
  echo "No dynamic PORT environment variable detected. Using default port configuration."
fi

# Launch the default startup script of the Suwayomi Docker container
exec /home/suwayomi/startup_script.sh
