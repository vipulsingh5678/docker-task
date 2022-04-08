FROM php:7.2-fpm-stretch

#Installing dependencied for mongodb and extention
RUN apt-get update \
    && apt-get install -y autoconf pkg-config libssl-dev \
    && pecl install mongodb \
    && echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini
#Installing extentions and enabling them
RUN buildDeps="libxml2-dev zlib1g-dev" \
    && apt-get update -y \
    && apt-get install $buildDeps -y \
    && pecl install redis psr-1.1.0  opcache xdebug   \
    && docker-php-ext-install soap opcache zip \
    && docker-php-ext-enable redis psr  xdebug opcache

ENV PHALCON_VERSION=4.1.1 
RUN curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz \
    && tar xzf v${PHALCON_VERSION}.tar.gz \
    && docker-php-ext-install ${PWD}/cphalcon-${PHALCON_VERSION}/build/php7/64bits 

RUN echo "session.save_path=\"/var/www/html/tmp\"" >> "$PHP_INI_DIR/php.ini"
#Installing ssh and configure connection with github
RUN apt-get install ssh -y
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the keys and set permissions
ADD ./id_rsa  /root/.ssh/id_rsa 
ADD ./id_rsa.pub /root/.ssh/id_rsa.pub 

RUN    chmod 600 /root/.ssh/id_rsa \
     &&   chmod 600 /root/.ssh/id_rsa.pub


#Installing some usefull tools
RUN apt-get update \
    && apt-get install -y libcurl4-openssl-dev  nano \
    && apt-get install -y  wget  git zip 

RUN mkdir -p /var/www/html/tmp \
    &&  chmod -R 777 /var/www/html/*
