FROM ubuntu:latest

WORKDIR /app
ADD . /app

# Use the default UTF-8 language.
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive   



RUN apt-get update \
    && apt-get -y install software-properties-common \
    && add-apt-repository ppa:ondrej/php \
    && apt-get update 
RUN apt-get install -y php7.2 \
    && apt-get install -y php7.2-fpm php7.2-cli  php7.2-psr php7.2-dev 
RUN apt-get install -y php7.2-phalcon4 
RUN apt-get install -y php7.2-redis php7.2-mongo  php7.2-json  \
    && apt-get clean && rm -rf /var/lib/apt/lists/

RUN apt-get update \
    && apt-get install nginx -y \
    && apt-get install supervisor -y \
    && apt-get install redis-server -y

#RUN cp info.php /var/www/html/

#RUN apt-get install curl -y 

WORKDIR /tmp


#RUN systemctl enable apache2

ADD https://github.com/phalcon/cphalcon/archive/v4.1.1.tar.gz	/tmp

RUN chmod 777 /tmp/    -R
RUN tar xzvf /tmp/v4.1.1.tar.gz


RUN /tmp/cphalcon-4.1.1/build/install
#RUN docker-php-ext-install /tmp/cphalcon-4.1.1/build/php7/64bits 


RUN echo "listen = 9000" >> "/etc/php/7.2/fpm/pool.d/www.conf"
#CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]

#ADD startup.sh /tmp/

COPY nginx.conf  /etc/nginx/sites-enabled/default

COPY info.php /var/www/html/

COPY nginx-selfsigned.crt /etc/ssl/nginx/
COPY nginx-selfsigned.key /etc/ssl/nginx/ 
#RUN /startup.sh
#CMD ["/tmp/startup.sh"]

#RUN apt-get install redis-server -y

#RUN apt-get -y install  supervisor
#RUN apt-get install supervisor -y
EXPOSE 80 443

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["supervisord" ,  "-c" ,   "/etc/supervisor/conf.d/supervisord.conf"]


