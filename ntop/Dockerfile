FROM ubuntu:latest
MAINTAINER SmartBlug <smartblug@smartextension.com>

# Update Ubuntu 
RUN \ 
	apt-get update && apt-get upgrade -y && \
	apt-get install -y wget unzip cron git

RUN \
	git clone https://github.com/ntop/ntopng.git && \
	cd ntopng && \
	./autogen.sh && \
	./configure && \
	make && \
	make install
