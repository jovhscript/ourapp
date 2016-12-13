#!/bin/bash
# CS207 AWS EC2 Ubuntu 16.04 instance provisioning script (for final project)
# Installs final project stack: numpy, Flask, SQL Alchemy, nginx, and PostgreSQL
# Also configures firewall for nginx HTTP access, starts nginx server,
# and runs basic checks to ensure installation completed and services started.

# show the current Python 3 version (if any)
python3 --version

# update / upgrade the current software libraries
sudo apt-get update
sudo apt-get --upgrade

# install Python3 pip and development essentials + the psycopg2 library for PostgreSQL access
printf "\n*******************************************************"
printf "\nInstalling virtualenv, python3-pip, and python3-dev ...\n"
sudo apt-get install virtualenv python3-pip python3-dev

# "~" specifies the AWS EC2 instance home directory for virtual environment
cd ~
mkdir envs

# use the AWS EC2 Ubuntu 16.04 instance python3 installation
virtualenv --python=/usr/bin/python3 envs/flaskproj
# source ~/envs/flaskproj/bin/activate

# install PostgreSQL
printf "\n*******************************************************"
printf "\nInstalling PostgreSQL ...\n"
sudo apt-get install postgresql
sudo apt-get install python-psycopg2
sudo apt-get install libpq-dev
sudo apt-get install postgresql-contrib
echo "PostgreSQL installed"

source ~/envs/flaskproj/bin/activate && pip install -r ~/ourapp/setup/Requirements.txt

printf "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

# install and configure nginx
printf "\n*******************************************************"
printf "\nInstalling and starting nginx ...\n"
sudo apt-get install nginx
sudo service nginx start

sudo cp /home/ubuntu/ourproject/setup/ourapp.service /etc/systemd/system/ourapp.service
sudo systemctl start ourapp
sudo systemctl enable ourapp

sudo cp  /home/ubuntu/ourproject/setup/ourapp /etc/nginx/sites-available/ourapp
sudo ln -s /etc/nginx/sites-available/ourapp /etc/nginx/sites-enabled

sudo nginx -t
sudo systemctl restart nginx
echo "nginx installed and configured \n"

printf "\n*******************************************************"
printf "\nInitialising the postgress database ...\n"
sudo -u postgres -- psql -f - <<HERE
alter user postgres password 'password';
create user cs207 createdb createuser password 'cs207password';
create database ts_postgres owner cs207;
HERE
source /home/ubuntu/envs/envs/flaskproj/bin/activate  && python /home/ubuntu/ourapp/setup/store_gen_ts.py

printf "\nFINISHED!\n"