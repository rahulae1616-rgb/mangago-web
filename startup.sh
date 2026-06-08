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

# Background daemon to wait for WebUI extraction and inject branding files
(
  echo "Custom UI/UX injection daemon started in background."
  # Wait for index.html to be extracted by the server
  while [ ! -f /tmp/Tachidesk/webUI-serve/index.html ]; do
    sleep 1
  done
  echo "Target index.html detected. Copying customization assets..."
  
  # Copy branding files to static serve directory
  cp /home/suwayomi/mangago-inject.css /tmp/Tachidesk/webUI-serve/mangago-inject.css
  cp /home/suwayomi/mangago-inject.js /tmp/Tachidesk/webUI-serve/mangago-inject.js
  cp /home/suwayomi/mangago-logo.png /tmp/Tachidesk/webUI-serve/mangago-logo.png
  
  # Inject the links into index.html if not already present
  if ! grep -q "mangago-inject.css" /tmp/Tachidesk/webUI-serve/index.html; then
    # Insert CSS link before </head>
    sed -i 's|</head>|<link rel="stylesheet" href="/mangago-inject.css"></head>|g' /tmp/Tachidesk/webUI-serve/index.html
    # Insert JS link before </body>
    sed -i 's|</body>|<script src="/mangago-inject.js" defer></script></body>|g' /tmp/Tachidesk/webUI-serve/index.html
    echo "Successfully injected assets into index.html!"
  fi
) &

# Launch the default startup script of the Suwayomi Docker container
exec /home/suwayomi/startup_script.sh


