#/bin/bash

if [ -f /LocalSettings.php ]
then
  echo ">> enabling LocalSettings"
  chmod a+r /LocalSettings.php
  sed -i 's/^$wgServer/#$wgServer/g' /LocalSettings.php
  ln -s /LocalSettings.php /usr/share/nginx/html/LocalSettings.php
fi

if [ -f /htpasswd ]
then
  echo ">> enabling htpasswd protection"
  chmod a+r /htpasswd
  sed -i 's/#auth_basic/auth_basic/g' /htpasswd
  ln -s /htpasswd /etc/nginx/htpasswd
fi

chmod a+rw -R /usr/share/nginx/data/

if [ -d /uploads ]
then
  echo ">> enabling uploads volume"
  mv /usr/share/nginx/html/images/* /uploads/
  rm -f /usr/share/nginx/html/images
  chmod a+rwx -R /uploads
  ln -s /uploads /usr/share/nginx/html/images
fi


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
