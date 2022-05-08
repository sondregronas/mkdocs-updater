FROM ubuntu:focal

LABEL org.opencontainers.image.source=https://github.com/sondregronas/mkdocs-updater
LABEL org.opencontainers.image.description="Automatically (every 2hrs) fetches mkdocs updates from GitHub and generates new static html."
LABEL maintainer="sondregronas"

ENV REPO='https://github.com/sondregronas/mkdocs-updater -b example'
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
            cron \
            pandoc \
            pandoc-citeproc \
            python3 \
            python3-pip \
            git \
            && rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN mkdir /site \
    && python3 -m pip install mkdocs \
    ##
    # Create crontask (updater.sh)
    && touch updater.sh \
    && echo "git -C /docs pull || git clone \$REPO /docs" >> updater.sh \
    && echo "cd /docs" >> updater.sh \
    && echo "python3 -m pip install -r requirements.txt || echo 'No requirements.txt found'" >> updater.sh \
    && echo "python3 -m mkdocs build -q -d /site" >> updater.sh \
    && echo "0 */2 * * * sh /updater.sh" | crontab - \
    ##
    # Create Entrypoint script
    && touch docker-entrypoint.sh \
    && echo "sh /updater.sh" >> docker-entrypoint.sh \
    && echo "cron -f" >> docker-entrypoint.sh

ENTRYPOINT ["sh", "docker-entrypoint.sh"]
