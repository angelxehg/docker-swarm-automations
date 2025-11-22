# Docker Swarm Automations

Collection of docker images and scripts to implement Docker Swarm Automations (Webhooks, Cron jobs)

Notes:
* Mount or copy yours scripts to `/home/automations/scripts/`.
* Write your logs to `/home/automations/logs/my-script.log`.
* Import included scripts from `/home/automations/included-scripts/`.
* Scripts should have execute permissions for `automations`, at least `u+x`.

## Local development

Start docker-compose:

```shell
docker compose up -d --build
```
