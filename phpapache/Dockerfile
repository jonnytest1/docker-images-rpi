FROM balenalib/rpi-raspbian:stretch

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && apt-get install -y \
	nano \
	patch \
	zip unzip \
	wget \
	curl \
	openssl \
	apache2 apache2-doc apache2-utils \
	#libapache2-mod-proxy-html \
	#libapache2-mod-fcgid \
	--no-install-recommends && \
	rm -rf /var/lib/apt/lists/* && \
	rm /var/www/html/index.html
RUN apt-get update && apt-get install -y \
	nano \
	zip unzip \
	wget \
	curl \
	imagemagick \
	sqlite sqlite3 \
	#sendmail-bin \
	php \
	php7.0 \
	php7.0-fpm \
	php7.0-cli \
	php7.0-json \
	php7.0-curl \
	php7.0-gd \
	php-imagick \
	php7.0-sqlite3 \
	php7.0-pgsql \
	php7.0-mysql \
	php7.0-mysqli \
	php7.0-imap \
	php7.0-xsl \
	php7.0-ldap \
	php-memcache \
	php7.0-mcrypt \
	#php-xdebug \
	php7.0-intl \
	#php7.0-xmlrpc \
	php7.0-xml \
	php-pear \
	php-geoip \
	php7.0-opcache \
	php-gettext \
	php7.0-zip \
	--no-install-recommends && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /var/www/html && chown -R www-data:www-data /var/www

RUN sed -ri -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' "/etc/apache2/apache2.conf" && \
	sed -ri -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' "/etc/apache2/sites-available/000-default.conf" && \
	sed -ri -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' "/etc/apache2/sites-available/default-ssl.conf"

RUN sed -i -e 's/error_log = \/var\/log\/php7.0-fpm.log/error_log = \/proc\/self\/fd\/2/g' /etc/php/7.0/fpm/php-fpm.conf && \
	sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php/7.0/fpm/php-fpm.conf && \
	sed -i -e 's/;access.log = log\/$pool.access.log/access.log = \/proc\/self\/fd\/2/g' /etc/php/7.0/fpm/pool.d/www.conf && \
	sed -i -e 's/;catch_workers_output = yes/catch_workers_output = yes/g' /etc/php/7.0/fpm/pool.d/www.conf && \
	sed -i -e 's/;clear_env = no/clear_env = no/g' /etc/php/7.0/fpm/pool.d/www.conf && \
	sed -i -e 's/listen = \/run\/php\/php7.0-fpm.sock/listen = [::]:9000/g' /etc/php/7.0/fpm/pool.d/www.conf && \
	mkdir -p /run/php

RUN apt-get update && apt-get upgrade
RUN apt-get install php-pear php7.0-dev php7.0-zip php7.0-curl php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-xml libapache2-mod-php7.0

RUN apt-get install php7.0-dev

RUN php -v
RUN /usr/sbin/a2enmod headers
RUN /usr/sbin/a2enmod rewrite
RUN /usr/sbin/a2enmod proxy
RUN /usr/sbin/a2enmod mime
RUN /usr/sbin/a2enmod proxy_http

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

RUN mkdir /phpdebug
RUN apt-get install php7.0-dev automake autoconf
RUN apt-get update && apt-get upgrade


ADD ./000-default.conf /etc/apache2/sites-enabled/000-default.conf
WORKDIR /phpdebug


RUN chmod -R 777 /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod g+s /var/www/html

ADD startup.sh /startup.sh
RUN chmod 777 /startup.sh

CMD /startup.sh



