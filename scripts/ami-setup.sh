#!/bin/bash
# Setup script for installing the application into an EC2 instance *outside* of Leastic Beanstalk
# Run as root
# patient-check-mobile.zip must be manually uploaded to /home/ec2-user/patient-check-mobile.zip prior to running
# Security sensitive data has been substituted with "xxx". Replace all occurrences  of "xxx" with appropriate values before running this script.
# TODO [chrisbingham]: Pull the application code from the git repo automatically

# Update all packages
yum update -y

# Install prereqs
yum install gcc gcc-c++ git nginx -y
cd /etc/yum.repos.d/
wget http://mongodb.ssl.amzn1.bauman.in/mongodb.ssl.amzn1.bauman.in.repo
yum install mongodb-server mongodb python-pymongo python-pymongo-gridfs -y

# Build and install the correct version of node.js
mkdir /root/build
cd /root/build
wget http://nodejs.org/dist/v0.10.26/node-v0.10.26.tar.gz
tar -xzf node-v0.10.26.tar.gz
cd node-v0.10.26
./configure
make
make install
sed -i '60s/.*/    pathmunge \/usr\/local\/bin/' /etc/bashrc
export PATH=/usr/local/bin:$PATH

#Enable services
chkconfig mongod on
chkconfig nginx on

# Install and configure App Prescribed
unzip /home/ec2-user/patient-check-mobile.zip -d /opt/app-prescribed
cd /opt/app-prescribed/patient-check-mobile/
npm install
npm run-script setup
echo "'use strict'; module.exports = { 'xxx': { password: 'xxx', notifications: { 'userRegistration': true }}};" > /opt/app-prescribed/patient-check-mobile/settings/admins.js
echo '{ "dev": false, "offline": false, "port": 8080, "adminPort": 8088, "url": "http://www.pilot.appprescribed.com", "db": { "name": "patient-check", "host": "127.0.0.1", "port": 27017 }, "mail": { "host": "appprescribedcom.domain.com", "port": "587", "auth": { "user": "xxx", "pass": "xxx" }, "secureConnection": false, "ignoreTLS": true, "maxConnections": 10, "from": "AppPrecribed.com <no-reply@appprescribed.com>" }, "mobile": { "port": 8008, "folderPath": ".\\public_mobile", "url": "http://mobile.pilot.appprescribed.com/", "jwtSecret": "secret", "componentsUrl": "http://mobile.pilot.appprescribed.com/preview/" }, "conference": { "port": 8888 }, "api": { "port": 8808, "url": "http://api.pilot.appprescribed.com" }}' > /opt/app-prescribed/patient-check-mobile/config.json
# TODO [chrisbingham]: config of mail server in config.json needed here

# Mount volumes
# This assumes that the volume to store MongoDB files is already attached to the instance at /dev/sdf (a.k.a. /dev/xvdf), partioned, and formatted with ext4
# This assumes that the volume to store attachment files is already attached to the instance at /dev/sdg (a.k.a. /dev/xvdg), partioned, and formatted with ext4
# TODO [chrisbingham]: Mount the volumes automatically via the AWS CLI
echo "/dev/xvdf1 /var/lib/mongodb ext4 defaults 0 0" >> /etc/fstab
echo "/dev/xvdg1 /opt/app-prescribed/patient-check-mobile/attachments ext4 defaults 0 0" >> /etc/fstab
mount -a
chown mongodb /var/lib/mongodb

# Configure nginx
# TODO [chrisbingham]: Replace these echo commands by pulling the nginx .conf file from the git repo
echo 'server { listen 80; server_name www.pilot.appprescribed.com; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection "upgrade"; proxy_http_version 1.1; proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; proxy_set_header Host $host; location / { proxy_pass http://localhost:8080; }}' >> /etc/nginx/conf.d/pilot.appprescribed.com.conf
echo 'server { listen 80; server_name admin.pilot.appprescribed.com; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection "upgrade"; proxy_http_version 1.1; proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; proxy_set_header Host $host; location / { proxy_pass http://localhost:8088; }}' >> /etc/nginx/conf.d/pilot.appprescribed.com.conf
echo 'server { listen 80; server_name mobile.pilot.appprescribed.com; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection "upgrade"; proxy_http_version 1.1; proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; proxy_set_header Host $host; location / { proxy_pass http://localhost:8008; }}' >> /etc/nginx/conf.d/pilot.appprescribed.com.conf
echo 'server { listen 80; server_name evisit.pilot.appprescribed.com; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection "upgrade"; proxy_http_version 1.1; proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; proxy_set_header Host $host; location / { proxy_pass http://localhost:8888; }}' >> /etc/nginx/conf.d/pilot.appprescribed.com.conf
echo 'server { listen 80; server_name api.pilot.appprescribed.com; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection "upgrade"; proxy_http_version 1.1; proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; proxy_set_header Host $host; location / { proxy_pass http://localhost:8808; }}' >> /etc/nginx/conf.d/pilot.appprescribed.com.conf

# Start services
service nginx start
service mongod start

# Start App Prescribed
cd /opt/app-prescribed/patient-check-mobile/
npm run-script upstart &