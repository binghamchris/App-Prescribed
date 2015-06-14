#!/bin/bash
# Post-deploy script for configuring the application after Elastic Beanstalk has deployed it

# Find out where Elastic Beanstalk deployed the application to and which user it runs under
EB_APP_CURRENT_DIR=$(/opt/elasticbeanstalk/bin/get-config container -k app_deploy_dir)
EB_APP_USER=$(/opt/elasticbeanstalk/bin/get-config container -k app_user)

# Make sure the application is stopped
su -s /bin/bash -c "cd $EB_APP_CURRENT_DIR; /opt/elasticbeanstalk/node-install/node-v0.10.26-linux-x64/bin/npm run-script unix-stop" $EB_APP_USER

#Configure the application
# Run the setup script
cd $EB_APP_CURRENT_DIR; /opt/elasticbeanstalk/node-install/node-v0.10.26-linux-x64/bin/npm run-script setup
# Retrieve the configuration files from the Git repo
wget -O /var/app/current/settings/admins.js https://raw.githubusercontent.com/binghamchris/App-Prescribed/master/config/admins.js
chown $EB_APP_USER:$EB_APP_USER /var/app/current/settings/admins.js
wget -O /var/app/current/config.json https://raw.githubusercontent.com/binghamchris/App-Prescribed/master/config/config.json
chown $EB_APP_USER:$EB_APP_USER /var/app/current/config.json

# Start the application again
su -s /bin/bash -c "cd $EB_APP_CURRENT_DIR; /opt/elasticbeanstalk/node-install/node-v0.10.26-linux-x64/bin/npm run-script upstart &" $EB_APP_USER
