FROM ghcr.io/suwayomi/suwayomi-server:stable

# Switch to root to perform configuration file operations
USER root

# Create the target configuration directory
RUN mkdir -p /home/suwayomi/.local/share/Tachidesk

# Copy our custom configuration file
COPY server.conf /home/suwayomi/.local/share/Tachidesk/server.conf

# Ensure correct ownership of files
RUN chown -R suwayomi:suwayomi /home/suwayomi/.local/share/Tachidesk

# Switch back to the suwayomi non-root user
USER suwayomi

# Copy our custom entrypoint startup script
COPY --chown=suwayomi:suwayomi startup.sh /home/suwayomi/startup.sh
RUN chmod +x /home/suwayomi/startup.sh

# Use our startup script as the entrypoint
ENTRYPOINT ["tini", "--"]
CMD ["/home/suwayomi/startup.sh"]
