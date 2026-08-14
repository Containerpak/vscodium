FROM ubuntu:26.04 AS source

ADD --checksum=sha256:b4edf5dd785826fb9539918e715671580395441ee15f090413fd6f89e1c617c7 \
    https://github.com/VSCodium/vscodium/releases/download/1.126.04524/codium_1.126.04524_amd64.deb \
    /tmp/codium.deb

FROM ghcr.io/containerpak/gtk3:main

RUN --mount=type=bind,from=source,source=/tmp/codium.deb,target=/run/codium.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/codium.deb && \
    rm -f /usr/share/codium/chrome-sandbox && \
    cpak-clean-junk
