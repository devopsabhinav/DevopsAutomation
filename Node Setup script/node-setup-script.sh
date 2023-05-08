#!/bin/bash

export node_version="14"
export swap_size="1G"

echo "Added swap size of $swap_size"
sudo fallocate -l $swap_size /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" >> /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf

echo "Setting up nodeJS............ "
sudo apt update
sudo curl -sL https://deb.nodesource.com/setup_$node_version.x | sudo bash -
sudo apt-get install -y nodejs
node -v

echo "Installing npm............."
sudo apt install npm -y

echo "Installing pm2............."
sudo npm install pm2 -g

echo "Successfully Node setup has been completed!!!"