FROM saunafs-base

RUN apt-get update && \
	apt-get install -y saunafs-metalogger && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY saunafs-metalogger.start.sh saunafs-metalogger.start.sh
RUN chmod +x saunafs-metalogger.start.sh

CMD ["./saunafs-metalogger.start.sh"]
