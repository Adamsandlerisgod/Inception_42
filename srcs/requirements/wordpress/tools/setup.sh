#!/bin/bash

# this script run in the building container
# it changes the ownership of the /var/www/inception/ folder to www-data user
# then sure that the wp-config.php file is in the /var/www/inception/ folder
# then it downloads the wordpress core files if they are not already there
# then it installs wordpress if it is not already installed
# and set the admin user and password if they are not already set
# this variables are set in the .env file
# the penultimate line download and activate the raft theme, that I liked most
# at the end, exec $@ run the next CMD in the Dockerfile.
# In this case: starts the php-fpm7.4 server in the foreground

# set -ex # print commands & exit on error (debug mode)

# WORDPRESS_URL=login.42.fr
# WORDPRESS_TITLE=Inception
# WORDPRESS_ADMIN_USERNAME=theroot
# WORDPRESS_ADMIN_PASSWORD=123
# WORDPRESS_ADMIN_EMAIL=theroot@123.com
# WORDPRESS_DEFAULT_USER=theuser
# WORDPRESS_DEFAULT_PASSWORD=abc
# WORDPRESS_DEFAULT_EMAIL=theuser@123.com
# WORDPRESS_DEFAULT_ROLE=editor

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