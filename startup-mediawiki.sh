#/bin/bash

chmod a+r /LocalSettings.php
sed -i 's/^$wgServer/#$wgServer/g' /LocalSettings.php
ln -s /LocalSettings.php /usr/share/nginx/html/LocalSettings.php

chmod a+rw -R /usr/share/nginx/data/

if [ ! -z ${MEDIAWIKI_HSTS_HEADERS_ENABLE+x} ]
then
  echo ">> HSTS Headers enabled"
  sed -i 's/#add_header Strict-Transport-Security/add_header Strict-Transport-Security/g' /etc/nginx/conf.d/nginx-piwik.conf

  if [ ! -z ${MEDIAWIKI_HSTS_HEADERS_ENABLE_NO_SUBDOMAINS+x} ]
  then
    echo ">> HSTS Headers configured without includeSubdomains"
    sed -i 's/; includeSubdomains//g' /etc/nginx/conf.d/nginx-piwik.conf
  fi
else
  echo ">> HSTS Headers disabled"
fi

if [ ! -z ${MEDIAWIKI_RELATIVE_URL_ROOT+x} ]
then
    mv /usr/share/nginx/html /mediawiki
    mkdir -p "/usr/share/nginx/html$MEDIAWIKI_RELATIVE_URL_ROOT"
    mv /mediawiki/* "/usr/share/nginx/html$MEDIAWIKI_RELATIVE_URL_ROOT"
fi