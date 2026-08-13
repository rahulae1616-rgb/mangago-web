#!/bin/bash
set -e

# Map PORT env var to BIND_PORT for Suwayomi
if [ -n "$PORT" ]; then
  echo "Dynamic PORT detected: $PORT. Mapping to BIND_PORT."
  export BIND_PORT=$PORT
elif [ -n "$SPACE_ID" ]; then
  echo "Hugging Face Space detected (SPACE_ID: $SPACE_ID). Mapping BIND_PORT to 7860."
  export BIND_PORT=7860
else
  echo "Defaulting BIND_PORT to 7860."
  export BIND_PORT=7860
fi

# Background: inject branding into WebUI after it gets extracted
INJECT_LOG="/tmp/mangago-inject.log"
(
  echo "[$(date)] Injection daemon started." > "$INJECT_LOG"

  # Wait for the WebUI index.html to appear (timeout 120s)
  WAIT=0
  while [ ! -f /tmp/Tachidesk/webUI-serve/index.html ]; do
    sleep 2
    WAIT=$((WAIT + 2))
    if [ "$WAIT" -ge 120 ]; then
      echo "[$(date)] TIMEOUT: index.html not found after 120s" >> "$INJECT_LOG"
      exit 1
    fi
  done
  echo "[$(date)] index.html found. Injecting assets..." >> "$INJECT_LOG"

  # Copy branding files
  cp /home/suwayomi/mangago-inject.css /tmp/Tachidesk/webUI-serve/mangago-inject.css
  cp /home/suwayomi/mangago-inject.js /tmp/Tachidesk/webUI-serve/mangago-inject.js
  cp /home/suwayomi/mangago-logo.png /tmp/Tachidesk/webUI-serve/mangago-logo.png

  # Inject links into index.html (idempotent)
  if ! grep -q "mangago-inject.css" /tmp/Tachidesk/webUI-serve/index.html; then
    sed -i 's|</head>|<link rel="stylesheet" href="/mangago-inject.css"></head>|g' /tmp/Tachidesk/webUI-serve/index.html
    sed -i 's|</body>|<script src="/mangago-inject.js" defer></script></body>|g' /tmp/Tachidesk/webUI-serve/index.html
    echo "[$(date)] Assets injected successfully." >> "$INJECT_LOG"
  else
    echo "[$(date)] Assets already injected, skipping." >> "$INJECT_LOG"
  fi
) &

# Launch Suwayomi server (replaces this process)
exec /home/suwayomi/startup_script.sh
