FROM  ubuntu:24.04
#BASE INSTALL

#INSTALL & UPGRADE
RUN apt-get update && apt-get upgrade -y 

## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Europe" > /tmp/preseed.txt; \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> /tmp/preseed.txt; \
    debconf-set-selections /tmp/preseed.txt && \
    apt-get update && \
    apt-get install -y tzdata ; dpkg-reconfigure tzdata 

## INSTALLING DEPENDENCIES
RUN apt-get install -y apache2-utils nginx-full wget curl zip unzip openssl

RUN mkdir -p /var/www/keeweb && mkdir /etc/nginx/external && mkdir -p mkdir -p /var/www/webdav/tmp && \
    cd /var/www/keeweb/ && wget https://github.com/keeweb/keeweb/releases/download/v1.18.7/KeeWeb-1.18.7.html.zip \ 
    && unzip KeeWeb-1.18.7.html.zip && rm -f KeeWeb-1.18.7.html.zip && rm -f /etc/nginx/sites-enabled/default \
    && chown www-data:www-data -R /var/www/webdav && chown www-data:www-data -R /var/www/keeweb/

#RUN sed -i 's#<meta name="kw-config" content="(no-config)">#<meta name="kw-config" content="default_config.json">#' /var/www/keeweb/index.html
   

COPY ./keeweb.conf /etc/nginx/conf.d/keeweb.conf
COPY ./start.sh /start.sh
RUN chmod +x /start.sh

 EXPOSE 80
 EXPOSE 443
 CMD [ "/start.sh" ]

