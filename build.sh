# TODO: Move to buildx
# Build
docker build -t sondregronas/mkdocs-updater:latest-amd64 --build-arg ARCH=amd64/ .
docker build -t sondregronas/mkdocs-updater:latest-arm64v8 --build-arg ARCH=arm64v8/ .
docker build -t sondregronas/mkdocs-updater:latest-arm32v7 --build-arg ARCH=arm32v7/ .

# Docker Hub
docker push sondregronas/mkdocs-updater:latest-amd64
docker push sondregronas/mkdocs-updater:latest-arm64v8
docker push sondregronas/mkdocs-updater:latest-arm32v7

docker manifest create \
sondregronas/mkdocs-updater:latest \
--amend sondregronas/mkdocs-updater:latest-amd64 \
--amend sondregronas/mkdocs-updater:latest-arm32v7 \
--amend sondregronas/mkdocs-updater:latest-arm64v8

docker manifest push sondregronas/mkdocs-updater:latest

# GHCR
docker tag sondregronas/mkdocs-updater:latest-amd64 ghcr.io/sondregronas/mkdocs-updater:latest-amd64
docker tag sondregronas/mkdocs-updater:latest-arm64v8 ghcr.io/sondregronas/mkdocs-updater:latest-arm64v8
docker tag sondregronas/mkdocs-updater:latest-arm32v7 ghcr.io/sondregronas/mkdocs-updater:latest-arm32v7

docker push ghcr.io/sondregronas/mkdocs-updater:latest-amd64
docker push ghcr.io/sondregronas/mkdocs-updater:latest-arm64v8
docker push ghcr.io/sondregronas/mkdocs-updater:latest-arm32v7

docker manifest create \
ghcr.io/sondregronas/mkdocs-updater:latest \
--amend ghcr.io/sondregronas/mkdocs-updater:latest-amd64 \
--amend ghcr.io/sondregronas/mkdocs-updater:latest-arm32v7 \
--amend ghcr.io/sondregronas/mkdocs-updater:latest-arm64v8

docker manifest push ghcr.io/sondregronas/mkdocs-updater:latest
