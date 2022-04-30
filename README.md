# mkdocs-updater
A docker container for automatically updating a mkdocs site using git.

`docker pull sondregronas/mkdocs-updater`
https://hub.docker.com/r/sondregronas/mkdocs-updater

Installs the packages `pandoc`, `pandoc-citeproc` which is required by some plugins. Base image is `ubuntu:focal`.

Automatically (every 2 hours) performs a `git pull` on the `${REPO}`, runs `pip install -r requirements.txt` in said repo, then performs a `mkdocs build`. Outputs static html in `/site`.

Example `docker-compose.yml`

```yaml
version: "3.3"
services:
  updater:
    image: sondregronas/mkdocs-updater
    restart: unless-stopped
    volumes:
      - content:/site
    environment:
      - REPO=https://github.com/server/repo/
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
