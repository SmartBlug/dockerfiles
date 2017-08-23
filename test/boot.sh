#!/bin/sh

/usr/bin/mysqld_safe &
/bin/sh /boot.onetime.sh
/usr/sbin/apache2 -D FOREGROUND
