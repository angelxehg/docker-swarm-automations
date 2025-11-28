# Docker Swarm Automations

Collection of docker images and scripts to implement Docker Swarm Automations (Webhooks, Cron jobs)

Notes:
* Mount your crontab to `/etc/crontabs/automations`. Use [Supercronic format](https://github.com/aptible/supercronic?tab=readme-ov-file#crontab-format).
* Mount or copy yours scripts to `/opt/automations/scripts/`.
* Import included scripts from `/opt/automations/included-scripts/`.
* Scripts should have execute permissions, at least `u+x`.

## Local development

Start docker-compose:

```shell
docker compose up -d --build
```
