FROM php:5.6-apache

ENV MAJOR_VERSION 6.5
ENV MINOR_VERSION 21
ENV SOURCEFORGE_MIRROR http://downloads.sourceforge.net
ENV WWW_FOLDER /var/www/html

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libcurl4-gnutls-dev libpng-dev unzip cron re2c php5-imap python less vim

RUN docker-php-ext-install mysql curl gd zip mbstring
#	apt-get install -y php5-mysql php5-imap php5-curl php5-gd curl unzip cron

WORKDIR /tmp

#ADD sugar_app_back.tgz /tmp

RUN     rm  -Rf ${WWW_FOLDER}/* && #\
	#cp -R /tmp/sugar_app_back/* ${WWW_FOLDER}/ && \
	#chown -R www-data:www-data ${WWW_FOLDER}/* && \
	#chown -R www-data:www-data ${WWW_FOLDER} && \
	#rm -Rf /tmp/Sugar*

# RUN sed -i 's/^upload_max_filesize = 2M$/upload_max_filesize = 10M/' /usr/local/etc/php/php.ini

ADD config.php.pyt /usr/local/src/config.php.pyt
ADD envtemplate.py /usr/local/bin/envtemplate.py

ADD init.sh /usr/local/bin/init.sh

RUN chmod g+w /var/www/html
RUN chmod u+x /usr/local/bin/init.sh

ADD crons.conf /root/crons.conf
RUN crontab /root/crons.conf

RUN groupadd -g 500 oinstall
RUN useradd -g 500 -G www-data -u 501 delphix


EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]
