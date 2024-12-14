#!/bin/bash

# this script run in the building container
# it creates start the mariadb service and create the database and users according to the .env file
# at the end, exec $@ run the next CMD in the Dockerfile.
# In this case: "mysqld_safe" that restart the mariadb service

# set -ex # print commands & exit on error (debug mode)

service mariadb start

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DATABASE_NAME;
CREATE USER IF NOT EXISTS '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO '$DATABASE_USER'@'%' IDENTIFIED BY '$DATABASE_PASSWORD';
GRANT ALL PRIVILEGES ON $DATABASE_NAME.* TO 'root'@'%' IDENTIFIED BY '$DATABASE_ROOT_PASSWORD';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DATABASE_ROOT_PASSWORD');
EOF

sleep 5

service mariadb stop

exec $@ 