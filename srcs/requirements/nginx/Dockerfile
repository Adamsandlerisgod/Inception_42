# Base image: Debian Bullseye
FROM debian:bullseye

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Install necessary packages: nginx, openssl, and vim (for debugging)
RUN apt update && apt install -y --no-install-recommends --no-install-suggests \
    nginx \
    openssl \
    vim && \
    rm -rf /var/lib/apt/lists/*  # Clean up unnecessary package lists

# ARG declarations to pass values from docker-compose.yml or .env
ARG SSL_CERTIFICATE_FOLDER
ARG SSL_CERTIFICATE_PATH
ARG SSL_KEY_PATH
ARG SSL_COUNTRY
ARG SSL_STATE
ARG SSL_LOCALITY
ARG SSL_ORGANIZATION
ARG SSL_UNIT
ARG SSL_COMMON_NAME

# Generate a self-signed SSL certificate using openssl
RUN mkdir -p ${SSL_CERTIFICATE_FOLDER} && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out ${SSL_CERTIFICATE_PATH} \
    -keyout ${SSL_KEY_PATH} \
    -subj "/C=${SSL_COUNTRY}/ST=${SSL_STATE}/L=${SSL_LOCALITY}/O=${SSL_ORGANIZATION}/OU=${SSL_UNIT}/CN=${SSL_COMMON_NAME}"

# Copy custom nginx configuration files into the container
COPY conf/nginx.conf /etc/nginx/
COPY conf/server.conf /etc/nginx/conf.d/

# Append SSL configuration to server.conf to enable SSL
RUN echo "\tserver_name ${SSL_COMMON_NAME};\n\
            \tssl_certificate ${SSL_CERTIFICATE_PATH};\n\
            \tssl_certificate_key ${SSL_KEY_PATH};\n\
            }" >> /etc/nginx/conf.d/server.conf

# Create the web root directory and set permissions for nginx
RUN mkdir -p /var/www/ && \
    chown -R www-data:www-data /var/www/

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
