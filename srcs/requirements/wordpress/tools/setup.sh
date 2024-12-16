#!/bin/bash

chown -R www-data:www-data /var/www/inception/

if [ ! -f "/var/www/inception/wp-config.php" ]; then
   mv /tmp/wp-config.php /var/www/inception/
fi

sleep 10

wp --allow-root --path="/var/www/inception/" core download || true

if ! wp --allow-root --path="/var/www/inception/" core is-installed;
then
    wp  --allow-root --path="/var/www/inception/" core install \
        --url=$WORDPRESS_URL \
        --title=$WORDPRESS_TITLE \
        --admin_user=$WORDPRESS_ADMIN_USERNAME \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL
fi;

if ! wp --allow-root --path="/var/www/inception/" user get $WORDPRESS_DEFAULT_USER;
then
    wp  --allow-root --path="/var/www/inception/" user create \
        $WORDPRESS_DEFAULT_USER \
        $WORDPRESS_DEFAULT_EMAIL \
        --user_pass=$WORDPRESS_DEFAULT_PASSWORD \
        --role=$WORDPRESS_DEFAULT_ROLE
fi;

wp --allow-root --path="/var/www/inception/" theme install raft --activate 

exec $@