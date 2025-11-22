# Cron
FROM alpine:3.22 AS cron

# Install cronie (cron daemon)
RUN apk add --no-cache cronie

# Create 'automations' user, directories, log file and a sample crontab
RUN adduser -D -h /home/automations automations && \
    mkdir "/home/automations/scripts" && \
    chown -R automations:automations "/home/automations/scripts" && \
    touch /home/automations/cron.log && \
    chown automations:automations /home/automations/cron.log && \
    echo "* * * * * echo \"Hello from \$(whoami) at \$(date)\" >> /home/automations/cron.log" > /var/spool/cron/crontabs/automations && \
    chmod 600 /var/spool/cron/crontabs/automations

# Run crond in foreground
CMD ["crond", "-f"]
