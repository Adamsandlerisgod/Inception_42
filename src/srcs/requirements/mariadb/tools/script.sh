#!/bin/sh

# Debugging: Print environment variables
echo "WORDPRESS_DB_NAME=${WORDPRESS_DB_NAME}"
echo "WORDPRESS_DB_USER=${WORDPRESS_DB_USER}"
echo "WORDPRESS_DB_PASSWORD=${WORDPRESS_DB_PASSWORD}"
echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
echo "MYSQL_PORT=${MYSQL_PORT}"
echo "MYSQL_ADRRESS=${MYSQL_ADRRESS}"

# # Update the init.sql file
# sed -i 's|{{WORDPRESS_DB_NAME}}|'${WORDPRESS_DB_NAME}'|g' /tmp/init.sql
# sed -i 's|{{WORDPRESS_DB_USER}}|'${WORDPRESS_DB_USER}'|g' /tmp/init.sql
# sed -i 's|{{WORDPRESS_DB_PASSWORD}}|'${WORDPRESS_DB_PASSWORD}'|g' /tmp/init.sql
# sed -i 's|{{MYSQL_ROOT_PASSWORD}}|'${MYSQL_ROOT_PASSWORD}'|g' /tmp/init.sql

# # Update the 50-server.cnf file
# sed -i 's|{{MYSQL_PORT}}|'${MYSQL_PORT}'|g' /etc/mysql/mariadb.conf.d/50-server.cnf
# sed -i 's|{{MYSQL_ADRRESS}}|'${MYSQL_ADRRESS}'|g' /etc/mysql/mariadb.conf.d/50-server.cnf

# if [ -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
# 	echo "WordPress already installed"
# 	mysqld_safe
# else
# 	# mysql_upgrade
# 	mysqld --init-file="/tmp/init.sql"
# fi



# Update the init.sql file with environment variable values
sed -i "s|{{WORDPRESS_DB_NAME}}|${WORDPRESS_DB_NAME}|g" /tmp/init.sql
sed -i "s|{{WORDPRESS_DB_USER}}|${WORDPRESS_DB_USER}|g" /tmp/init.sql
sed -i "s|{{WORDPRESS_DB_PASSWORD}}|${WORDPRESS_DB_PASSWORD}|g" /tmp/init.sql
sed -i "s|{{MYSQL_ROOT_PASSWORD}}|${MYSQL_ROOT_PASSWORD}|g" /tmp/init.sql
sed -i "s|{{HOSTNAME}}|${HOSTNAME}|g" /tmp/init.sql

# Print the contents of init.sql to verify substitution
echo "Contents of /tmp/init.sql after substitution:"
cat /tmp/init.sql

# Update the 50-server.cnf file
sed -i "s|{{MYSQL_PORT}}|${MYSQL_PORT}|g" /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s|{{MYSQL_ADRRESS}}|${MYSQL_ADRRESS}|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# Print the contents of 50-server.cnf to verify substitution
echo "Contents of /etc/mysql/mariadb.conf.d/50-server.cnf after substitution:"
cat /etc/mysql/mariadb.conf.d/50-server.cnf

# Check if the WordPress database already exists
if [ -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
    echo "WordPress already installed"
    mysqld_safe
else
    mysqld --init-file="/tmp/init.sql"
fi
