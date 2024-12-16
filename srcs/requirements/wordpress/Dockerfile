

FROM debian:bullseye

# Expose the port used by PHP-FPM
EXPOSE 9000

# Define a default ARG for PHP configuration path
ARG PHPPATH=/etc/php/7.4/fpm

# Install required packages
RUN apt update && \
    apt install -y --no-install-recommends \
        ca-certificates \
        php7.4-fpm \
        php7.4-mysql \
        wget \
        tar && \
    rm -rf /var/lib/apt/lists/*

# Stop PHP-FPM service to avoid conflicts during configuration
RUN service php7.4-fpm stop

# Copy PHP-FPM pool configuration
COPY conf/www.conf ${PHPPATH}/pool.d/

# Update PHP and PHP-FPM configurations
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
    sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|g' ${PHPPATH}/pool.d/www.conf && \
    sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
    sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# Download and configure WP-CLI
RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create required directories for PHP-FPM and WordPress
RUN mkdir -p /run/php/ /var/run/php/ /var/www/inception/

# Set ownership of WordPress directory to the www-data user
RUN chown -R www-data:www-data /var/www/inception/

# Copy WordPress configuration and setup script
COPY conf/wp-config.php /tmp/
COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

# Run the setup script and start PHP-FPM in the foreground
CMD ["setup.sh", "php-fpm7.4", "--nodaemonize"]
