FROM ubuntu:16.04

# Install cron
RUN apt-get update \
	&& apt-get -y install cron \
	&& rm -rf /var/lib/apt/lists/*

# Make sure to log to Docker
RUN mkfifo /var/log/cron.log

# Setup start script
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh && cron && tail -f /var/log/cron.log
