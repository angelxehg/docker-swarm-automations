# Build supercronic
FROM golang:alpine AS build-supercronic
WORKDIR /go/src/github.com/aptible/supercronic
RUN apk add --no-cache git
RUN git clone https://github.com/aptible/supercronic.git . && \
    git checkout v0.2.39 && \
    go build -o /usr/local/bin/supercronic .

# Build webhook. Taken from https://github.com/almir/docker-webhook
FROM golang:alpine AS build-webhook

# Install dependencies
WORKDIR /go/src/github.com/adnanh/webhook
ENV WEBHOOK_VERSION=2.8.2
RUN apk add --update -t build-deps curl libc-dev gcc libgcc

# Download and build webhook
RUN curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
    tar -xzf webhook.tar.gz --strip 1
RUN go mod download
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /usr/local/bin/webhook

# Base
FROM docker:29.0.2-cli-alpine3.22 AS base

# Install common dependencies
ARG AWS_ENABLED=false
RUN apk add --no-cache \
    netcat-openbsd \
    curl \
    jq && \
    if [ "$AWS_ENABLED" = "true" ]; then apk add --no-cache aws-cli; fi

# Create non root user
RUN adduser -D automations && \
    mkdir -p /opt/automations/included-scripts && \
    mkdir -p /opt/automations/scripts && \
    chown -R automations:automations /opt/automations
# TODO: remove logs directory, not used anymore

# Copy included scripts
COPY --chown=automations:automations ./scripts/ /opt/automations/included-scripts/

# Webhook
FROM base AS webhook

# Install webhook dependencies
RUN apk add --no-cache \
    ca-certificates \
    tzdata

# Copy built webhook
COPY --from=build-webhook /usr/local/bin/webhook /usr/local/bin/webhook

WORKDIR     /etc/webhook
VOLUME      ["/etc/webhook"]
EXPOSE      9000
USER        automations
ENTRYPOINT  ["/usr/local/bin/webhook"]

# Cron
FROM base AS cron

# Copy supercronic binary
COPY --from=build-supercronic /usr/local/bin/supercronic /usr/local/bin/supercronic

# Configure crontabs
RUN mkdir -p /etc/crontabs && \
    chown automations:automations /etc/crontabs && \
    chmod 700 /etc/crontabs && \
    # Create default crontab \
    echo "* * * * * echo \"Hello from \$(whoami) at \$(date)\"" > /etc/crontabs/automations && \
    chown automations:automations /etc/crontabs/automations && \
    chmod 600 /etc/crontabs/automations

# Run supercronic in foreground as non root
USER automations
CMD ["/usr/local/bin/supercronic", "/etc/crontabs/automations"]
