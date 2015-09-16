#!/bin/sh

set -e

if [ -z "$DB_HOST_NAME" ]; then
	export DB_HOST_NAME=$DB_PORT_3306_TCP_ADDR
fi

if [ -z "$DB_TCP_PORT" ]; then
	export DB_TCP_PORT=$DB_PORT_3306_TCP_PORT
fi

if [ -z "$DB_USER_NAME" ]; then
	export DB_USER_NAME=$DB_ENV_MYSQL_USER
fi

if [ -z "$DB_PASSWORD" ]; then
	export DB_PASSWORD=$DB_ENV_MYSQL_PASSWORD
fi

if [ -z "$DATABASE_NAME" ]; then
	export DATABASE_NAME=$DB_ENV_MYSQL_DATABASE
fi

if [ -f "/mnt/sugarapp/index.php" ]; then
	#ls -lart /mnt/sugarapp/index.php
	#rm -Rf /var/www/html/*
	#su delphix -c "cp -R /mnt/sugarapp/* /var/www/html/."
    ln -s /mnt/sugarapp /var/www/html    
	chown -R www-data.www-data /var/www/html
fi
su delphix -c "/usr/local/bin/envtemplate.py -i /usr/local/src/config.php.pyt -o /var/www/html/config.php"
/usr/sbin/cron

rm -Rf /tmp/Sugar* /tmp/sugar*
apachectl -DFOREGROUND
