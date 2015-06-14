#!/bin/bash
# Post-deploy script for configuring the application after Elastic Beanstalk has deployed it

# Find out where Elastic Beanstalk deployed the application to
EB_APP_CURRENT_DIR=$(/opt/elasticbeanstalk/bin/get-config container -k app_deploy_dir)

# Make sure the application is stopped
su -s /bin/bash -c "cd $EB_APP_CURRENT_DIR; npm run-script unix-stop" $EB_APP_USER

#Configure the application
# Run the setup script
su -s /bin/bash -c "cd $EB_APP_CURRENT_DIR; npm run-script setup" $EB_APP_USER
# Retrieve the configuration files from the Git repo
wget -O /var/app/current/settings/admin.js https://raw.githubusercontent.com/binghamchris/App-Prescribed/master/config/admin.js
chown $EB_APP_USER:$EB_APP_USER /var/app/current/settings/admin.js
wget -O /var/app/current/config.json https://raw.githubusercontent.com/binghamchris/App-Prescribed/master/config/config.json
chown $EB_APP_USER:$EB_APP_USER /var/app/current/config.json

# Start the application again
su -s /bin/bash -c "cd $EB_APP_CURRENT_DIR; npm run-script upstart &" $EB_APP_USER