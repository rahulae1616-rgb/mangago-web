#!/bin/bash
# Map the standard dynamic PORT environment variable (used by Render, Railway, etc.)
# to BIND_PORT (used by Suwayomi-Server).
if [ -n "$PORT" ]; then
  echo "Dynamic PORT detected: $PORT. Mapping to BIND_PORT."
  export BIND_PORT=$PORT
elif [ -n "$SPACE_ID" ]; then
  echo "Hugging Face Space detected (SPACE_ID: $SPACE_ID). Mapping BIND_PORT to 7860."
  export BIND_PORT=7860
else
  echo "No dynamic PORT environment variable detected. Defaulting BIND_PORT to 7860 for compatibility."
  export BIND_PORT=7860
fi

# Launch the default startup script of the Suwayomi Docker container
exec /home/suwayomi/startup_script.sh

