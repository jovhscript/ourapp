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

##Step 4:

