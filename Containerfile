FROM ubuntu:26.04 AS source

ADD --checksum=sha256:5f5c00a9da9d232e4c84e9eee68bbdeb4d8737462022626ce3bdb6948f3d8649 \
    https://github.com/VSCodium/vscodium/releases/download/1.135.06055/codium_1.135.06055_amd64.deb \
    /tmp/codium.deb

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/codium.deb,target=/run/codium.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/codium.deb && \
    rm -f /usr/share/codium/chrome-sandbox && \
    cpak-clean-junk
