FROM saunafs-base:latest

# Install SaunaFS chunkserver package
RUN apt-get update && apt-get install -y saunafs-chunkserver

# Unminimize
RUN echo "y" | unminimize

# Create necessary directories
RUN mkdir -p /mnt/hd1 /mnt/hd2 && \
    chown saunafs:saunafs /mnt/hd*

# Set up configuration directory and files
RUN mkdir -p /etc/saunafs && \
    cp /usr/share/doc/saunafs-chunkserver/examples/sfschunkserver.cfg /etc/saunafs/ && \
    cp /usr/share/doc/saunafs-chunkserver/examples/sfshdd.cfg /etc/saunafs && chown -R saunafs:saunafs /etc/saunafs/

# Add mount points to sfshdd.cfg
RUN echo "/mnt/hd1" >> /etc/saunafs/sfshdd.cfg && \
    echo "/mnt/hd2" >> /etc/saunafs/sfshdd.cfg

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9422

USER saunafs

ENTRYPOINT ["/entrypoint.sh"]
