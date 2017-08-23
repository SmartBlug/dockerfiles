FROM alpine:latest
MAINTAINER SmartBlug <smartblug@smartextension.com>

RUN 	apk update && \
	apk upgrade

RUN	apk add apache2 && \
	apk add php7-apache2 
#	apk add openrc

RUN sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#ServerName www.example.com:80#\nServerName localhost:80#' /etc/apache2/httpd.conf

RUN 	mkdir -p /run/apache2 && chown -R apache:apache /run/apache2
COPY	boot.sh /boot.sh
RUN	chmod u+x /boot.sh

EXPOSE	80 443

#CMD ["/sbin/init"]
CMD ["/boot.sh"]
