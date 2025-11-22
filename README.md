# Docker Swarm Automations

Collection of docker images and scripts to implement Docker Swarm Automations (Webhooks, Cron jobs)

Notes:
* Mount or copy yours scripts to `/home/automations/scripts/`.
* Import included scripts from `/home/automations/included-scripts/`.
* Scripts should have execute permissions for `automations`, at least `u+x`.

## Local development

Create an empty log file at `logs/cron.log`:

```shell
touch logs/cron.log
```

Start docker-compose:

```shell
docker compose up -d --build
```
