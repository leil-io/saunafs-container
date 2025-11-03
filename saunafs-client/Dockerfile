FROM saunafs-base

RUN apt-get update && \
	apt-get install -y saunafs-client saunafs-adm && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY saunafs-client.start.sh saunafs-client.start.sh
RUN chmod +x saunafs-client.start.sh

ENTRYPOINT ["./saunafs-client.start.sh"]
