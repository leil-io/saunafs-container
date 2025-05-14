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

# Install SaunaFS master package
RUN apt-get update && apt-get install -y saunafs-master

# Create dedicated user and volume path
RUN mkdir -p /var/lib/saunafs && \
    chown saunafs:saunafs /var/lib/saunafs

RUN dpkg -L saunafs-master
RUN find /usr/share/doc/saunafs-master/
# Copy all example configs into /etc/saunafs
RUN mkdir -p /etc/saunafs && \
    cp /usr/share/doc/saunafs-master/examples/*.cfg /etc/saunafs/

# Copy init metadata file if needed (safe default)
# Format metadata directly in image
RUN cp -a /var/lib/saunafs/metadata.sfs.empty /var/lib/saunafs/metadata.sfs && \
    chown saunafs:saunafs /var/lib/saunafs/metadata.sfs

VOLUME ["/var/lib/saunafs"]

EXPOSE 9419
EXPOSE 9420
EXPOSE 9421

USER saunafs

CMD ["/usr/sbin/sfsmaster", "-c", "/etc/saunafs/sfsmaster.cfg"]

