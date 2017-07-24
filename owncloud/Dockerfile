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
        php7.0-zip php7.0-xml php7.0-mbstring \
	lsb-release

# Download Owncloud
RUN \
        wget https://download.owncloud.org/community/owncloud-10.0.2.zip && \
        unzip owncloud-10.0.2.zip && \
        rm owncloud-10.0.2.zip && \
        cp -r owncloud /var/www

# Configure APACHE
COPY    owncloud.conf /etc/apache2/sites-available

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
COPY apache.crt /etc/apache2/ssl/apache.crt
COPY apache.key /etc/apache2/ssl/apache.key

# Install MariaDB
RUN \
	apt-get install -y software-properties-common && \
	apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
	#add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu $(lsb_release -cs) main' && \
	echo "deb  http://ftp.utexas.edu/mariadb/repo/10.1/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/mariadb.list && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server

RUN \
	sed -i '/^bind-address*/ s/^/#/' /etc/mysql/my.cnf && \
	sed -i '/^datadir*/ s|/var/lib/mysql|/data/mysql|' /etc/mysql/my.cnf && \
	rm -Rf /var/lib/mysql && \
	mysql_install_db 

#&& \
#	/usr/bin/mysqld_safe &
#RUN \
#  DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server
#RUN \ 
#  rm -rf /var/lib/apt/lists/* && \
#  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
#  echo "mysqld_safe &" > /tmp/config && \
#  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
#  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
#  bash /tmp/config && \
#  rm -f /tmp/config

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define working directory.
#WORKDIR /data

# Define default command.
#CMD ["/usr/bin/mysqld_safe"]

COPY    boot.sh /boot.sh
RUN     chmod u+x /boot.sh

COPY	boot.onetime.sh /boot.onetime.sh
RUN     chmod u+x /boot.onetime.sh

RUN	rm /etc/apache2/sites-enabled/default-ssl.conf
EXPOSE  80 443

#CMD ["/sbin/init"]
CMD ["/boot.sh"]

#CMD  ["/bin/sh","start.sh"]

#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
#CMD ["mysqld_safe"]

