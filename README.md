# Docker MediaWiki Container (based on marvambass/nginx-ssl-php)
_maintained by MarvAmBass_

[FAQ - All you need to know about the marvambass Containers](https://marvin.im/docker-faq-all-you-need-to-know-about-the-marvambass-containers/)

## What is it

This Dockerfile (available as ___marvambass/mediawiki___) gives you a completly secure MediaWiki.

The best is to just start this container if it's needed. And keep it stopped afterwarts.

It's based on the [marvambass/nginx-ssl-php](https://registry.hub.docker.com/u/marvambass/nginx-ssl-php/) Image

View in Docker Registry [marvambass/mediawiki](https://registry.hub.docker.com/u/marvambass/mediawiki/)

View in GitHub [MarvAmBass/docker-mediawiki](https://github.com/MarvAmBass/docker-mediawiki)

## Environment variables and defaults

* __DH\_SIZE__
 * default: 2048 fast but a bit unsecure. if you need more security just use a higher value
* __MEDIAWIKI\_RELATIVE\_URL\_ROOT__
 * default: _/_ - you can chance that to /phpmyadmin or what you need
* __MEDIAWIKI\_HSTS\_HEADERS\_ENABLE__
 * default: not set - if set to any value the HTTP Strict Transport Security will be activated on SSL Channel
* __MEDIAWIKI\_HSTS\_HEADERS\_ENABLE\_NO\_SUBDOMAINS__
 * default: not set - if set together with __MEDIAWIKI\_HSTS\_HEADERS\_ENABLE__ and set to any value the HTTP Strict Transport Security will be deactivated on subdomains

## Using the marvambass/mediawiki Container

You can use SQLite or MySQL or Postgresql as a Database.

So you might want to use a running MySQL Container (you could use: [marvambass/mysql](https://registry.hub.docker.com/u/marvambass/mysql/)).

You need to _--link_ your mysql container to marvambass/phpmyadmin

    docker run -d \
    -p 443:443 \
    --link mysql:mysql \
    -v /my/dbpath/:/usr/share/nginx/data/ \
    -v /my/uploads/:/uploads \
    -v /my/LocalSettings.php:/LocalSettings.php \
    --name mediawiki \
    marvambass/mediawiki

