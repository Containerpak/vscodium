FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:b4edf5dd785826fb9539918e715671580395441ee15f090413fd6f89e1c617c7 https://github.com/VSCodium/vscodium/releases/download/1.126.04524/codium_1.126.04524_amd64.deb /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libgtk-3-0 libnss3 && \
    dpkg-deb -x /tmp/source / && ln -s /usr/share/codium/bin/codium /usr/bin/codium && \
    cpak-clean-junk
