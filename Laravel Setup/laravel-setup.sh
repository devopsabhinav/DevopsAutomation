#!/bin/bash

export php_version="4.1"
export swap_size="1G"

echo "Added swap size of $swap_size"
sudo fallocate -l $swap_size /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
sudo echo "vm.swappiness=10" >> /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
sudo echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

echo "Setting up apache Server............ "
sudo apt update
sudo apt install apache2 -y
sudo a2enmod rewrite
sudo apt install zip unzip

echo "Installing PHP............."
sudo apt-get update
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt -y install php$php_version
sudo apt-get install -y php$php_version-{gd,common,curl,mysql,xml,zip,mbstring,bcmath}

echo "Installing Composer............."
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=$(curl -sS https://composer.github.io/installer.sig)
echo $HASH
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo "Successfully Laravel setup has been completed!!!"