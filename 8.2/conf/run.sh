#!/bin/bash

if [ "$XDEBUG" != "on" ]; then
    sed -i -e 's/^zend_extension/\;zend_extension/g' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

if [[ ! -z "$USER_ID" ]]; then
    usermod -o -u $USER_ID www-data
fi

if [[ ! -z "$GROUP_ID" ]]; then
    groupmod -o -g $GROUP_ID www-data
fi

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
