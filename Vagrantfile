# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"
require "fileutils"

current_dir = File.dirname(File.expand_path(__FILE__))
config_file = YAML.load_file("#{current_dir}/vagrant.config.yaml")
opt         = config_file['options']

Vagrant.configure("2") do |config|
  config.vm.box = opt["box"]
  # Run `vagrant box outdated` to check for updates.
  config.vm.box_check_update = false

  opt["forwarded_ports"].each do |port|
    config.vm.network "forwarded_port", guest: port["guest"], host: port["host"]
  end

  config.vm.network "private_network", ip: opt["ip"]
  config.vm.hostname = opt["hostname"]

  # Update local /etc/hosts to use hostname from above.
  if Vagrant.has_plugin?("vagrant-hostsupdater")
    config.hostsupdater.remove_on_suspend = true
  else
    config.vagrant.plugins = "vagrant-hostsupdater"
  end

  if opt["synced_folders"]
    opt["synced_folders"].each do |folder|
      # Create local directory in case it doesn't already exist.
      FileUtils.mkdir_p(folder['host'])

      config.vm.synced_folder folder['host'], folder['guest']
    end
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Provisioning WordPress VM..."
    WP_RELEASE="#{opt['wordpress']['release'] || 'latest'}"
    WP_DOMAIN="#{opt['hostname']}"
    WP_ADMIN_USERNAME="#{opt['wordpress']['user']}"
    WP_ADMIN_PASSWORD="#{opt['wordpress']['password']}"
    WP_ADMIN_EMAIL="#{opt['wordpress']['email']}"
    WP_DB_NAME="#{opt['wordpress']['db']['name']}"
    WP_DB_USERNAME="#{opt['wordpress']['db']['user']}"
    WP_DB_PASSWORD="#{opt['wordpress']['db']['password']}"
    MYSQL_ROOT_PASSWORD="root"

    apt-get update
    apt-get upgrade

    echo "Installing Apache web server..."
    apt-get install -y apache2

    # if ! [ -L /var/www ]; then
    #   rm -rf /var/www
    #   ln -fs /vagrant /var/www
    # fi

    echo "Configuring Apache..."
    # Append desired server name to Apache config file.
    # echo "ServerName localhost" >> /etc/apache2/apache2.conf
    a2enmod rewrite
    service apache2 restart

    echo "Installing PHP..."
    apt-get install -y php5 php5-mysql

    echo "Installing MySQL..."
    debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
    debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
    apt-get install -y mysql-server

    echo "Setting up MySQL database..."
    echo "CREATE USER $WP_DB_USERNAME@localhost IDENTIFIED BY '$WP_DB_PASSWORD';" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
    echo "CREATE DATABASE $WP_DB_NAME;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
    echo "GRANT ALL ON $WP_DB_NAME.* TO $WP_DB_USERNAME@localhost;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD

    echo "Installing wp-cli..."
    curl -sS -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    echo "Downloading WordPpress release '${WP_RELEASE}'..."
    cd /var/www/html
    curl -sS https://wordpress.org/$WP_RELEASE.tar.gz | tar xfz -
    mv wordpress/* .
    rm index.html
    rmdir wordpress
    # rm wordpress.tar.gz

    echo "Updating Wordpress configuration file..."
    cp -f wp-config-sample.php wp-config.php
    sed -i s/database_name_here/$WP_DB_NAME/ wp-config.php
    sed -i s/username_here/$WP_DB_USERNAME/ wp-config.php
    sed -i s/password_here/$WP_DB_PASSWORD/ wp-config.php
    echo "define('FS_METHOD', 'direct');" >> wp-config.php

    chown -R www-data:www-data /var/www/html

    echo "Initializing WordPress settings..."
    curl -sS "http://$WP_DOMAIN/wp-admin/install.php?step=2" \
      --data-urlencode "weblog_title=$WP_DOMAIN"\
      --data-urlencode "user_name=$WP_ADMIN_USERNAME" \
      --data-urlencode "admin_email=$WP_ADMIN_EMAIL" \
      --data-urlencode "admin_password=$WP_ADMIN_PASSWORD" \
      --data-urlencode "admin_password2=$WP_ADMIN_PASSWORD" \
      --data-urlencode "pw_weak=1"

    echo
    echo "======================================"
    echo "          VARIABLE DUMP"
    echo "======================================"
    echo "WP_RELEASE = $WP_RELEASE"
    echo "WP_DOMAIN = $WP_DOMAIN"
    echo "WP_ADMIN_USERNAME = $WP_ADMIN_USERNAME"
    echo "WP_ADMIN_PASSWORD = $WP_ADMIN_PASSWORD"
    echo "WP_ADMIN_EMAIL = $WP_ADMIN_EMAIL"
    echo "WP_DB_NAME = $WP_DB_NAME"
    echo "WP_DB_USERNAME = $WP_DB_USERNAME"
    echo "WP_DB_PASSWORD = $WP_DB_PASSWORD"
    echo
    echo "Open http://$WP_DOMAIN/wp-admin/"
    echo "and log in with"
    echo "Username: $WP_ADMIN_USERNAME"
    echo "Password: $WP_ADMIN_PASSWORD"
    echo

  SHELL
end
