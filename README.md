# mkdocs-updater
[![Build Status](https://img.shields.io/github/workflow/status/sondregronas/mkdocs-updater/CI)](https://github.com/sondregronas/mkdocs-updater/)
[![GitHub latest commit](https://img.shields.io/github/last-commit/sondregronas/mkdocs-updater)](https://github.com/sondregronas/mkdocs-updater/commit/)
[![AGPLv3 license](https://img.shields.io/github/license/sondregronas/mkdocs-updater)](https://www.gnu.org/licenses/agpl-3.0.en.html)
[![Docker](https://img.shields.io/docker/pulls/sondregronas/mkdocs-updater)](https://hub.docker.com/r/sondregronas/mkdocs-updater)
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
#		Alternatively clone a specific branch
#      - REPO=https://github.com/username/your-docs-repo -b branch
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

## Todo:
- Make a GitHub build action for continuous delivery to GitHub pages, alternatively a webhook option to force updates on pushes for local deployments. [Existing solutions](https://github.com/marketplace/actions/deploy-mkdocs) running on `alpine` does work, but `pandoc` is not supported.
- Only run `requirements.txt` when changes are detected.
- Pop & replace `/docs` directory when environment variable `REPO` changes.
