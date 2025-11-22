# Base
FROM alpine:3.22 AS base

# Install common dependencies
RUN apk add --no-cache netcat-openbsd

# Cron
FROM base AS cron

# Install cronie (cron daemon)
RUN apk add --no-cache cronie

# Configure automations user and crontab
RUN adduser -D -h /home/automations automations && \
    # Create directories \
    mkdir "/home/automations/included-scripts" && \
    mkdir "/home/automations/scripts" && \
    chown -R automations:automations "/home/automations/included-scripts" && \
    chown -R automations:automations "/home/automations/scripts" && \
    # Create log file \
    touch /home/automations/cron.log && \
    chown automations:automations /home/automations/cron.log && \
    # Configure crontabs \
    mkdir -p /etc/crontabs && \
    chown root:root /etc/crontabs && \
    chmod 755 /etc/crontabs && \
    # Create default crontab \
    echo "* * * * * echo \"Hello from \$(whoami) at \$(date)\" >> /home/automations/cron.log" > /etc/crontabs/automations && \
    chown automations:automations /etc/crontabs/automations && \
    chmod 600 /etc/crontabs/automations

# Copy included scripts
COPY --chown=automations:automations ./scripts/ /home/automations/included-scripts/

# Run crond in foreground
CMD ["crond", "-f"]
