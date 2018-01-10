FROM php:7.1-apache

# Image based on the Wordpress docker image from:

MAINTAINER opsforge.io
LABEL name="grav-docker"
LABEL version="1.0.1"

# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
    wget \
    unzip \
		libjpeg-dev \
		libpng12-dev \
    zlib1g-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
  apt-get clean && \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install gd zip opcache
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
		echo 'upload_max_filesize=128M'; \
		echo 'post_max_size=128M'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires

VOLUME /var/www/html

ENV SOURCE="/usr/src/grav"

RUN set -ex; \
  wget https://getgrav.org/download/core/grav-admin/latest && \
  unzip latest && \
  mkdir -p "$SOURCE" && \
  cp -r grav-admin/. "$SOURCE" && \
  rm -rf grav-admin latest && \
  chown -R www-data:www-data "$SOURCE"

COPY docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh && \
  chown root:root /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2-foreground"]
