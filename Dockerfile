# A basic apache server with PHP. To use either add or bind mount content under /var/www
# https://docs.docker.com/engine/reference/builder/

FROM ubuntu:20.04

# Use bash instead of sh.
SHELL ["/bin/bash", "-c"]

WORKDIR /app
ADD . /app

# Use the default UTF-8 language.
ENV LANG C.UTF-8

RUN apt-get update && apt-get -y install software-properties-common && add-apt-repository ppa:ondrej/php && apt-get update && apt-get install -y apache2 && apt-get install -y php7.2 && apt-get install -y libapache2-mod-php7.2 php7.2-curl php7.2-json && apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

ADD ./projCert/website/ /var/www/html/website/

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
