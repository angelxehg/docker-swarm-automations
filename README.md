# Docker Swarm Automations

Collection of docker images and scripts to implement Docker Swarm Automations (Webhooks, Cron jobs)

## Local development

Create an empty log file at `logs/cron.log`:

```shell
touch logs/cron.log
```

Start docker-compose:

```shell
docker compose up -d --build
```
