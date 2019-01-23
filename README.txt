Questions:

a) Supposing you had to decide on a cloud computing service to host a web application for a project, which service would you use and why?

Amazon web service because it was the first company to incursion in the cloud service and offers extensive admin controls, an extensive range of IaaS and PaaS and features highly customizable options for your what you need. Even offering a free trial which you can choose either to pay the plan or cancel your AWS subscription.

b) You're trying to install a couple of dependencies for an application on a server. A dependency listed in the requirements is not available in the default package manager. What would be your approach to resolve the issue?

I will install the required dependencies manually that are not listed before installing the ones in the default package manager.

c) There is a service that exits randomly on a server. No one has been able to figure out why this happens. It's an important service and needs to have as little downtime as possible.

                c.1) How would you identify what's happening?

First, I will see how widespread is the problem so I could eliminate variables of what could it be, second I will compare the last functioning server service configuration and the last changes that could have been made to see if it's affecting the service. If there is a monitoring tool in the server, I will analyze the details of the alerts and analyze logs of the system.

                c.2) What can you do to ensure immediate service continuity while the root cause is identified and a real solution is found?

I will transfer to a cloud server the last functional copy of the service available to be operational until me and my team resolve the problem.



Starting the scripts for ubuntu server

1.) Downloading the Ubuntu server 18.04 image
Done with no problems.

2.)Making an Ubuntu virtual machine on VMware workstation
Done with no problems.
 
3.)Installing PHP 7.2
Done with no problems.

commands used:
sudo apt-get install php -y
sudo apt-get install php-xml -y
sudo apt-get install php-mysql -y
sudo apt-get install php-mbstring -y


4.)Installing Nginx
Done with no problems.

commands used:
sudo apt install nginx -y


5.) Installing MySql
Done with no problems

commands used:
sudo apt-get install mysql-server -y
sudo mysql_secure_installation


5.)Installing composer
Done with no problems

commands used:
sudo apt install composer -y


6.)Installing Node (with yarn)

I didn't know how yarn worked or what it was, so I investigate what was it functionalities so I could install nodejs afterward.

I read that when you install yarn and don't have node.js it will install it automatically with the installation of yarn so I verified the installation of node. After I installed yarn, I verify it with a command to check the version (node -v) the output was:v8.10.0 which is the most recent version. Mission accomplished...

Before the installation I installed curl with the following command:
sudo apt install curl -y

commands used:
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update

sudo apt install yarn -y


7.) Installing Redis

I read that using apt-get install Redis-server wouldn't get the most updated version of Redis I tested this looking up for the most recent version of Redis on its page and typing apt-cache policy Redis-server output was 4.0.9, being the updated and stable version 5.0.3, so I searched for another method.
I went to the official web page of Redis to get the best instruction for installation. I needed an essential package to compile the binaries and Tcl to test them, I installed them with the following commands: 
sudo apt-get install build-essential tcl -y

commands used:
sudo apt-get install build-essential tcl -y

wget http://download.redis.io/releases/redis-5.0.3.tar.gz

tar xzf redis-5.0.3.tar.gz

cd redis-5.0.3

make


The first task of the test done with success.


The second task:

2) Create a script (or set of scripts) that can configure a sample application from scratch. The sample application is https://github.com/soluciones-gbh/ReactJSLaravel5.5. To properly set up the sample application, you'll need to include the following instructions into your scripts:

Problems:
running composer install I got 4 problems, all of them pointing that I was missing a PHP extension (mob) that was missing in the system. I resolve the problem with sudo apt-get install PHP-XML which installed the missing dependencies, worked like a charm. Then I ran composer update. And finally, composer install.

After using yarn install I got an error because I didn't have libpng-dev... I solved installing it with sudo apt-get install libpng-dev.

No problems Generating the key.

When doing the migration I had a lot of problems... the error said that the user homestead didn't have access to the database. I've figured out where this configuration was( on the .env file) I opened with my text editor and found the database user and password that it had for default. I tried to add a MySQL user with a new database to fit the .env user it had. At the end y opted to change some things in the .env files as listed:

DB_HOST=localhost
DB_DATABASE=laravelu
DB_USERNAME=root
DB_PASSWORD=''

I went to MySQL added the database name I replaced on the .env file (laravelu) and it was good to go.

I had no problems with the migration.

Finally, with the last step, I didn't have any problems, the program was built correctly.


Bonus:
Using Ansible & and Dockers for the Scripts

Ansible:
I didn't have any experience using ansible before so I started learning on my own how to use it. With the first script I made, I tried to duplicate it with the commands and modules from Ansible. This was the result:

---
 - hosts: localhost (Used localhost so it can run on any machine)
   user: root
   vars: 
    yarn_version: 1.13.0
   tasks:
   - name: Installing the neccesary
     apt:
       name: update
     apt:
       name: upgrade
     apt:
       name: curl
       state: present

   - name: Installing PHP 
     apt:
       name: php
     apt:
       name: php-xml
     apt:
       name: php-mysql
     apt:
       name: php7.2-mbstring
 
   - name: Installing Nginx 
     apt:
       name: nginx

   - name: Installing composer 
     apt:
       name: composer

   - name: Installing MySQL
     apt:
       name: mysql-server
      

   - name: Configure the Yarn APT key
     apt_key: url=https://dl.yarnpkg.com/debian/pubkey.gpg

(Couldn't find a way to install Redis)



Docker:
I've already had some experience creating docker files and making custom images, but nothing too complicated so this was a challenge to me. This was the result:

FROM ubuntu

MAINTAINER nicasiobernie99@gmail.com

 ENV TERM=xterm\
    TZ=Europe/Berlin\
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt install curl -y


#Installing PHP
RUN apt-get install php -y
RUN apt-get install php-xml -y
RUN apt-get install php-mysql -y
RUN apt-get install php-mbstring -y

#Installing Nginx
RUN apt install nginx -y

#Installing MySQL
RUN apt-get install mysql-server -y


#Installing composer
RUN apt install composer -y


#Installing Yarn
RUN apt-get install gnupg2 -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update

RUN apt install yarn -y

(Couldn't find a way to install Redis)