FROM saunafs-base

RUN apt-get update && \
	apt-get install -y saunafs-chunkserver && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY saunafs-chunkserver.start.sh /saunafs-chunkserver.start.sh
RUN chmod +x /saunafs-chunkserver.start.sh

EXPOSE 9422

CMD ["/saunafs-chunkserver.start.sh"]
