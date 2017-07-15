FROM ubuntu:latest
MAINTAINER SmartBlug <smartblug@smartextension.com>

# Update Ubuntu 
RUN \ 
	apt-get update && apt-get upgrade -y && \
	apt-get install -y wget unzip cron

RUN \
	apt install -y apache2 mariadb-server libapache2-mod-php7.0 \
		php7.0-gd php7.0-json php7.0-mysql php7.0-curl \
		php7.0-intl php7.0-mcrypt php-imagick \
		php7.0-zip php7.0-xml php7.0-mbstring
# Download Owncloud
RUN \
	wget https://download.owncloud.org/community/owncloud-10.0.2.zip && \
	unzip owncloud-10.0.2.zip && \
	rm owncloud-10.0.2.zip && \
	cp -r owncloud /var/www

# Configure APACHE
COPY 	owncloud.conf /etc/apache2/sites-available

RUN \
	ln -s /etc/apache2/sites-available/owncloud.conf /etc/apache2/sites-enabled/owncloud.conf && \
	a2enmod rewrite && \
	a2enmod headers && \
	a2enmod env && \
	a2enmod dir && \
	a2enmod mime && \
	a2enmod ssl && \
	a2ensite default-ssl

RUN \ 
	chown -R www-data:www-data /var/www/owncloud/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Install MariaDB
#RUN \
#	apt-get install -y mysql-server 
#RUN \
#	mysql_secure_installation
#	apt-get install -y software-properties-common && \
#	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8

#COPY	mariadb.list /etc/apt/sources.list.d/mariadb.list

#RUN \
#	apt update && \
#	DEBIAN_FRONTEND=noninteractive apt install -y mariadb-server
# Install server
# Install MariaDB.
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db && \
  echo "deb http://mariadb.mirror.iweb.com/repo/10.0/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/mariadb.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mysqld_safe"]

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
#CMD ["mysqld_safe"]
