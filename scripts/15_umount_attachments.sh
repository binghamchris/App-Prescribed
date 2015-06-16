#!/bin/bash
# Unmount the attachments EBS volume before cleaning the old version of the application.

# Find out where Elastic Beanstalk deployed the application to
EB_APP_CURRENT_DIR=$(/opt/elasticbeanstalk/bin/get-config container -k app_deploy_dir)
# Find out if the attachments volume is mounted
MOUNT_STATUS=$(/bin/df | /bin/grep "${EB_APP_CURRENT_DIR}/attachments")

# If the attachments volume is mounted, unmount it.
if [ -n "${MOUNT_STATUS}" ] ; then
  umount ${EB_APP_CURRENT_DIR}/attachments
fi
