
FROM php:7.2-fpm-stretch
RUN buildDeps="libxml2-dev zlib1g-dev" \
    && apt-get update -y \
    && pecl install redis psr-1.1.0 mongodb opcache xdebug    \
    && docker-php-ext-enable redis psr mongodb xdebug opcache  
RUN apt-get update \
    && apt-get install -y libcurl4-openssl-dev ssh nano \
    && apt-get install -y pkg-config libssl-dev wget  git
#COPY info.php /var/www/html/
ENV PHALCON_VERSION=4.1.1 
RUN curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz \
    && tar xzf v${PHALCON_VERSION}.tar.gz \
    && docker-php-ext-install ${PWD}/cphalcon-${PHALCON_VERSION}/build/php7/64bits 

#RUN  apt-get install redis-server -y
RUN echo "session.save_path=\"/var/www/html/tmp\"" >> "$PHP_INI_DIR/php.ini"

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Add the keys and set permissions
ADD ./id_rsa  /root/.ssh/id_rsa 
ADD ./id_rsa.pub /root/.ssh/id_rsa.pub 

RUN    chmod 600 /root/.ssh/id_rsa \
     &&   chmod 600 /root/.ssh/id_rsa.pub

###############ENV PHPREDIS_VERSION 3.0.0

#RUN mkdir -p /usr/src/php/ext/redis \
#    && curl -L https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz | tar xvz -C /usr/src/php/ext/redis --strip 1 \
#RUN echo 'redis' >> /usr/src/php-available-exts \
#    && docker-php-ext-install redis

#RUN  apt-get install nano -y

#RUN apt-get install nginx -y
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#EXPOSE 80 9000

#COPY ./nginx.conf  /etc/nginx/conf.d/default.conf

#COPY ./info.php  /var/www/html/



#RUN apt-get -y install  supervisor

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["supervisord" ,  "-c" ,   "/etc/supervisor/conf.d/supervisord.conf"]


#ADD startup.sh /tmp/

#RUN chmod 777 /tmp -R


#RUN /startup.sh
#CMD ["/tmp/startup.sh"]
#CMD /tmp/startup.sh
#ENTRYPOINT ["/bin/bash", "/tmp/startu

