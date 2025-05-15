FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    gnupg2 curl lsb-release ca-certificates apt-transport-https sudo

# GPG and keyring setup
RUN gpg2 --list-keys || true && \
    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/saunafs-archive-keyring.gpg \
        --keyserver hkps://keyserver.ubuntu.com \
        --receive-keys 0xA80B96E2C79457D4 && \
    gpg --no-default-keyring \
        --keyring /usr/share/keyrings/saunafs-archive-keyring.gpg \
        --export --armor > /usr/share/keyrings/saunafs-archive-keyring.asc

# Add SaunaFS APT source
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/saunafs-archive-keyring.asc] https://repo.saunafs.com/repository/saunafs-ubuntu-24.04/ noble main" \
    > /etc/apt/sources.list.d/saunafs.list

# Add repository credentials
RUN mkdir -p /etc/apt/auth.conf.d && \
    echo "machine https://repo.saunafs.com/repository/saunafs-ubuntu-24.04/ login docker password jaVw6MsYJhB3nxY" \
    > /etc/apt/auth.conf.d/saunafs.conf

# Add utils
RUN apt install -y iproute2
