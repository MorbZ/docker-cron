This Docker image allows defining cron jobs via environment variables and logs the cron output to the Docker logs.

## Features ##
- Cron jobs can be defined via environment variables
- Cron logs can be viewed in the Docker logs
- Standalone script available for inclusion in existing images

## Usage ##
When using this image you can define cron jobs via `CRON_*` environment variables. Every enviroment variable that starts with `CRON_` will be added as a cron entry. The standard and error logs of the cron command can be viewed in the Docker logs.

### Docker Compose ###
Here is a sample docker-compose file that will start 2 cron jobs:

```yaml
version: '3'
services:
  cron:
    image: morbz/docker-cron
    environment:
      - CRON_MINUTE=* * * * * root echo "Hello minute"
      - CRON_HOUR=0 * * * * root echo "Hello hour"
```

This will print `Hello minute` every minute and `Hello hour` every full hour to the Docker logs.

### Standalone Script ###
The best way to use this image is to use it as a base image. However if you have to extend from another image you can use the standalone script to use the cron service. Keep in mind that the CMD is overridden and a previously defined CMD will not be executed. Make sure you extend from an Ubuntu base image and cron is installed.

A sample Dockerfile might look like this:

```
FROM ubuntu:16.04

# Install cron
RUN apt-get update \
	&& apt-get -y install cron \
	&& rm -rf /var/lib/apt/lists/*
	
#
# Custom commands
#

# Start standalone cron script
ADD https://raw.githubusercontent.com/MorbZ/docker-cron/master/standalone.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh
```