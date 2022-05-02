# mkdocs-updater
[![GitHub version](https://badge.fury.io/gh/Naereen%2FStrapDown.js.svg)](https://github.com/sondregronas/mkdocs-updater/)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](http://perso.crans.org/besson/LICENSE.html)
[![Docker](https://badgen.net/badge/icon/docker?icon=docker&label)](https://hub.docker.com/r/sondregronas/mkdocs-updater)
[![Buymeacoffee](https://badgen.net/badge/icon/buymeacoffee?icon=buymeacoffee&label)](https://www.buymeacoffee.com/u92RMis)

A container for automatically updating a mkdocs site using Git.

The container is bundles with the packages `pandoc` and `pandoc-citeproc` which is required by some plugins. The base image is `ubuntu:focal`.

Automatically (every 2 hours) performs a `git pull` on the `${REPO}`, then runs `pip install -r requirements.txt` & `mkdocs build -d /site` in said repo. Works great in conjunction with a static html server.

## Example `docker-compose.yml`
```yaml
version: "3.3"
services:
  updater:
    image: "ghcr.io/sondregronas/mkdocs-updater:latest"
    restart: unless-stopped
    volumes:
      - content:/site
    environment:
      - REPO=https://github.com/username/your-docs-repo
  http:
    image: nginx:latest
    volumes:
      - content:/usr/share/nginx/html
    restart: unless-stopped
    ports:
      - "80:80"

volumes:
  content:
```
