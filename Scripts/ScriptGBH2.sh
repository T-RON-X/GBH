#!/bin/bash

#All that is necesary before
sudo apt-get install php7.2-xml

#.env file
cp .env.example .env

#Composer Install
composer update
composer install

#Yarn Install
sudo apt-get install libpng-dev -y
yarn install

#Generate an App key:
sudo php artisan key:generate

#making some changes in the .env file
nano .env

#Creating the sql database
sudo mysql

#Migrate the database configuration
sudo php artisan migrate

#Ensuring the app works
sudo apt-get update
sudo apt-get install npm
yarn run prod
