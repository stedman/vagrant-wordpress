#!/usr/bin/env bash

apt-get update
apt-get upgrade

# Install Apache web server.
apt-get install -y apache2


# if ! [ -L /var/www ]; then
#   rm -rf /var/www
#   ln -fs /vagrant /var/www
# fi

# Append desired server name to Apache config file.
echo "ServerName localhost" >> /etc/apache2/apache2.conf

service apache2 restart

# Install PHP and MySQL.
apt-get install php5 php5-mysql mysql-server
