FROM saunafs-base

RUN apt-get update && \
	apt-get install -y saunafs-master && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Define a non-volume-mapped path for templates
ENV SAUNAFS_TEMPLATE_DIR=/opt/saunafs/templates

RUN mkdir -p ${SAUNAFS_TEMPLATE_DIR} && \
	cp /var/lib/saunafs/metadata.sfs.empty ${SAUNAFS_TEMPLATE_DIR}/metadata.sfs.empty

COPY saunafs-master.start.sh /saunafs-master.start.sh
RUN chmod +x /saunafs-master.start.sh

EXPOSE 9419 9420 9421

CMD ["/saunafs-master.start.sh"]
