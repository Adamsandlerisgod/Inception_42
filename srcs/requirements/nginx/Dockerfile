FROM debian:bookworm

RUN apt update && apt upgrade -y && apt install -y nginx openssl  && apt install -y vim

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/mycert.crt -keyout /etc/nginx/ssl/mykey.key -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=whendrik.42.fr"

# Only change ownership of the necessary directories, not the entire /etc/
RUN chown -R 777 /etc/nginx/ssl /etc/nginx/



# COPY ./tools/hostname.sh /etc/hostnaminator.sh

# RUN chmod 777 /etc/hostnaminator.sh

# RUN /etc/hostnaminator.sh

# RUN echo "127.0.0.1 whendrik.42.fr" >> /etc/hosts

# RUN chown -R 777 /etc/

# COPY ./config/default.conf /etc/nginx/conf.d/default.conf
COPY ./config/nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
