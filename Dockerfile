FROM marvambass/nginx-ssl-php
MAINTAINER MarvAmBass

ENV DH_SIZE 2048

RUN apt-get update; apt-get install -y \
    mysql-client \
    php5-mysql \
    php5-sqlite \
    php5-pgsql \
    php5-gd \
    php5-intl \
    php5-geoip \
    php5-xcache \
    texlive \
    curl \
    zip

RUN curl -O https://releases.wikimedia.org/mediawiki/1.25/mediawiki-1.25.1.tar.gz
RUN rm -rf /usr/share/nginx/html && tar xf media*tar.gz && rm media*tar.gz && mv mediawiki* /usr/share/nginx/html

# prepare for sqlite db
RUN mkdir -p /usr/share/nginx/data; chmod a+w /usr/share/nginx/data/
VOLUME /usr/share/nginx/data/
VOLUME /uploads/

ADD nginx-mediawiki.conf /etc/nginx/conf.d/nginx-mediawiki.conf

ADD startup-mediawiki.sh /opt/startup-mediawiki.sh
RUN chmod a+x /opt/startup-mediawiki.sh
RUN sed -i 's/# exec CMD/&\n\/opt\/startup-mediawiki.sh/g' /opt/entrypoint.sh
