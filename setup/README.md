#HOW TO SET UP:

We really work hard to have a proper setup script ready but failed to do it in time. Nevertheless, if the website is running at (http://ec2-54-164-101-248.compute-1.amazonaws.com)[http://ec2-54-164-101-248.compute-1.amazonaws.com/meta], we also wanted you to be able to set it up on any other instance. 

This is why we created a manual guide to install our app.

##Step 1: Install Git
1. sudo apt-get update
2. sudo apt-get install git

##Step 2: Clone the repo
1. git clone https://github.com/jovhscript/ourapp

##Step 3: Update the correct IP
1. cd ourapp/setup
2. Update `ourapp` so that `TOBECHANGED` points to the public IP of your instance

##Step 4: Install VirtualEnv
1. cd ~
2. sudo apt-get install python3-pip python3-dev
2. sudo pip3 install virtualenv

##Step 5: Create VirtualEnv
1. mkdir envs
2. virtualenv envs/flaskproj
3. source envs/flaskproj/bin/activate

##Step 6: Install Postgres

1. sudo apt-get install postgresql
2. sudo apt-get install python-psycopg2
3. sudo apt-get install libpq-dev
4. sudo apt-get install postgresql-contrib

##Step 6: Install Python package
1. cd ourapp/setup/
2. pip install -r Requirements.txt

##Step 7: Install and configure Nginx

1. sudo apt-get install nginx
2. sudo cp ./ourapp.service /etc/systemd/system/ourapp.service
3. sudo systemctl start ourapp
4. sudo systemctl enable ourapp
5. sudo cp ./ourapp /etc/nginx/sites-available/ourapp
6. sudo ln -s /etc/nginx/sites-available/ourapp /etc/nginx/sites-enabled
7. sudo systemctl restart nginx

##Step 8: Create the Postgres DB
1. sudo -u postgres -- psql -f - <<HERE
alter user postgres password 'password';
create user cs207 createdb createuser password 'cs207password';
create database ts_postgres owner cs207;
HERE

##Step 9: Launch the server
1. cd ~/ourapp/timeseries/queries
2. nohup python server.py &

#PS: 
You might need to fix some permission issues that we still encounter sometimes as well as restart the instance.