FROM	debian:bullseye

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y nginx openssl net-tools vim \
    && rm -rf /var/lib/apt/lists/*
	
RUN		mkdir -p /etc/nginx/ssl
RUN		openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/whendrik.42.fr.key \
		-out /etc/nginx/ssl/whendrik.42.fr.crt \
		-subj "/C=TH/ST=Bangkok/L=Bangkok/O=42/OU=42Bangkok/CN=whendrik.42.fr"

# COPY /etc/nginx/ssl 


# COPY index.html /usr/share/nginx/html/index.html
# COPY ./conf/nginx.crt /etc/nginx/ssl/
# COPY ./conf/nginx.key /etc/nginx/ssl/
COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]