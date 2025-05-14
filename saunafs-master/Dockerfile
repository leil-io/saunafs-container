FROM saunafs-base:latest

# Install SaunaFS master package
RUN apt-get update && apt-get install -y saunafs-master

# Create dedicated user and volume path
RUN mkdir -p /var/lib/saunafs && \
    chown saunafs:saunafs /var/lib/saunafs


# Copy all example configs into /etc/saunafs

RUN echo "y" | unminimize

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


