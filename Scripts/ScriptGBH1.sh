#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt install curl -y


#Installing PHP
sudo apt-get install php -y
sudo apt-get install php-xml -y
sudo apt-get install php-mysql -y
sudo apt-get install php-mbstring -y


#Installing Nginx
sudo apt install nginx -y


#Installing MySlq
sudo apt-get install mysql-server -y
sudo mysql_secure_installation


#Installing composer
sudo apt install composer -y


#Installing Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update

sudo apt install yarn -y


#Installing Redis
sudo apt-get install build-essential tcl -y

wget http://download.redis.io/releases/redis-5.0.3.tar.gz

tar xzf redis-5.0.3.tar.gz

cd redis-5.0.3

make
