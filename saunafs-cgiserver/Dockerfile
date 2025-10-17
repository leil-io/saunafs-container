FROM saunafs-base

# Install the specified SaunaFS package
RUN apt-get update && \
	apt-get install -y saunafs-cgiserv && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/python3", "/usr/sbin/saunafs-cgiserver", "H", "master", "-v", "-P", "9425"]
