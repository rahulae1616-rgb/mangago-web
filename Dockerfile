FROM ghcr.io/suwayomi/suwayomi-server:stable

# Switch to root to perform configuration file operations
USER root

# Create the target configuration directory
RUN mkdir -p /home/suwayomi/.local/share/Tachidesk

# Copy our custom configuration file
COPY server.conf /home/suwayomi/.local/share/Tachidesk/server.conf

# Ensure correct ownership of files
RUN chown -R suwayomi:suwayomi /home/suwayomi/.local/share/Tachidesk

# Grant full read/write/execute permissions to any user running the container
RUN chmod -R 777 /home/suwayomi

# Switch back to the suwayomi non-root user
USER suwayomi

# Copy our custom entrypoint startup script and branding files
COPY --chown=suwayomi:suwayomi startup.sh /home/suwayomi/startup.sh
COPY --chown=suwayomi:suwayomi mangago-inject.js /home/suwayomi/mangago-inject.js
COPY --chown=suwayomi:suwayomi mangago-inject.css /home/suwayomi/mangago-inject.css
COPY --chown=suwayomi:suwayomi mangago-logo.png /home/suwayomi/mangago-logo.png
RUN chmod +x /home/suwayomi/startup.sh

# Use our startup script as the entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/home/suwayomi/startup.sh"]

