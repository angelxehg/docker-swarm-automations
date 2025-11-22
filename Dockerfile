# Base
FROM docker:29.0.2-cli-alpine3.22 AS base

# Install common dependencies
RUN apk add --no-cache \
    aws-cli \
    netcat-openbsd \
    curl \
    jq

# Create non root user
RUN adduser -D -h /home/automations automations && \
    # Create directories \
    mkdir "/home/automations/included-scripts" && \
    mkdir "/home/automations/scripts" && \
    mkdir "/home/automations/logs" && \
    chown -R automations:automations "/home/automations/included-scripts" && \
    chown -R automations:automations "/home/automations/scripts" && \
    chown -R automations:automations "/home/automations/logs"

# Copy included scripts
COPY --chown=automations:automations ./scripts/ /home/automations/included-scripts/

# Cron
FROM base AS cron

# Install cronie (cron daemon)
RUN apk add --no-cache \
    cronie

# Configure crontabs
RUN mkdir -p /etc/crontabs && \
    chown root:root /etc/crontabs && \
    chmod 755 /etc/crontabs && \
    # Create default crontab \
    echo "* * * * * echo \"Hello from \$(whoami) at \$(date)\" >> /home/automations/logs/cron.log 2>&1" > /etc/crontabs/automations && \
    chown automations:automations /etc/crontabs/automations && \
    chmod 600 /etc/crontabs/automations

# Run crond in foreground
CMD ["crond", "-f"]
