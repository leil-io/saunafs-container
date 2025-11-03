ARG BASE_IMAGE=ubuntu:24.04
FROM $BASE_IMAGE
LABEL maintainer="contact@saunafs.com"

# Install required packages
RUN apt-get update && \
	apt-get install -y --no-install-recommends gnupg wget dirmngr util-linux dialog ca-certificates && \
	yes | unminimize && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Ensure gnupg home exists before importing key
RUN mkdir -p /root/.gnupg

# Update CA certificates before running gpg
RUN update-ca-certificates && \
	gpg --no-default-keyring \
	--keyring /usr/share/keyrings/saunafs-archive-keyring.gpg \
	--keyserver hkps://keyserver.ubuntu.com \
	--receive-keys 0xA80B96E2C79457D4

# Use BuildKit secret for apt authentication, install, then remove the secret file in the same layer
RUN --mount=type=secret,id=apt_auth,mode=0444 \
	cp /run/secrets/apt_auth /etc/apt/auth.conf.d/saunafs.conf && \
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/saunafs-archive-keyring.gpg] https://repo.saunafs.com/repository/saunafs-ubuntu-24.04/ noble main" > /etc/apt/sources.list.d/saunafs.list
