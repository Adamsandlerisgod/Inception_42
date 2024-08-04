# FROM debian:bullseye

# RUN apt-get update && apt-get install -y php php-mysql php-fpm php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip mariadb-server mariadb-client
# COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
# COPY ./conf/init.sql /tmp/init.sql
# COPY tools/script.sh /usr/local/bin/.

# RUN mkdir -p /var/run/mysqld && \
# 	chown -R mysql:mysql /var/run/mysqld && \
# 	chmod 777 /var/run/mysqld

# RUN chmod +x /usr/local/bin/script.sh


# EXPOSE 3306

# ENTRYPOINT [ "/usr/local/bin/script.sh" ]

# # CMD ["mysqld"]
# CMD [ "/usr/bin/mysqld_safe" ]

FROM debian:bullseye

# INSTALL DEPENDENCIES
RUN		apt update -y && \
		apt upgrade -y && \
		apt-get install -y \
			mariadb-server \
			mariadb-client && \
		mkdir -p /var/run/mysqld && \
		chown -R mysql:mysql /var/run/mysqld && \
		chown -R mysql:mysql /etc/mysql

COPY	./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY	./conf/init.sql /tmp/init.sql
COPY	./tools/script.sh /tmp/script.sh

RUN		chown -R mysql:mysql /etc/mysql && \
		chown -R mysql:mysql /tmp/

# Not supposed to be exposed to the host machine
# EXPOSE	3306

USER	mysql

ENTRYPOINT	["sh", "/tmp/script.sh"]