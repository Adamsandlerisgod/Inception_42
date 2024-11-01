#!/bin/bash

echo "Hello maria"
/etc/init.d/mariadb start

if [ -d "/var/lib/mysql/$DB_NAME" ]
then
	echo "Database exists"
else

mysql_secure_installation << EOF

Y
Y
$DB_ROOT
$DB_ROOT
Y
N
Y
Y
EOF

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT'; FLUSH PRIVILEGES;" | mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME; GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;" | mysql -uroot

fi

/etc/init.d/mariadb stop

exec "$@"