#!/usr/bin/env bash

## --- Update OS --- ##
sudo apt-get update
#sudo apt-get upgrade -y

## --- Install programming essential bundles --- ##
cd ~
sudo apt-get install build-essential -y

## --- Install NGINX web server --- ##
sudo apt-get install -y nginx
# copy webserver file over
sudo cp /vagrant/.provision/default /etc/nginx/sites-available
# restart NGINX service
sudo systemctl restart nginx
# allow NGINX through firewall
sudo ufw allow 'Nginx Full'

## --- Install MongoDB Community Edition --- ##
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
sudo apt-get update
sudo apt-get install -y mongodb-org
## --- Create DB Directory --- ##
cd /
sudo mkdir data
sudo mkdir data/db

## --- Install Python and Gunicorn Resources --- ###
sudo apt-get install -y python python-pip python-virtualenv gunicorn
sudo virtualenv env
source env/bin/activate
# install Flask
sudo pip install Flask
return

## --- Install Supervisor --- ##
sudo apt-get install -y supervisor
sudo cp /vagrant/.provision/flask_project.conf /etc/supervisor/conf.d/
sudo supervisorctl reread
sudo supervisorctl update
