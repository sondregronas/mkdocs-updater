# Example from `mkdocs-updater`
[https://github.com/sondregronas/mkdocs-updater](https://github.com/sondregronas/mkdocs-updater)

Expected to see your own mkdocs site instead? Make sure to pass your GitHub repository as an `environment:` variable in your `docker-compose.yml` like so:
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
