# Docker Swarm Automations

Collection of docker images and scripts to implement Docker Swarm Automations (Webhooks, Cron jobs)

Notes:
* Mount or copy yours scripts to `/opt/automations/scripts/`.
* Write your logs to `/opt/automations/logs/my-script.log`.
* Import included scripts from `/opt/automations/included-scripts/`.
* Scripts should have execute permissions for `automations`, at least `u+x`.

## Local development

Start docker-compose:

```shell
docker compose up -d --build
```
