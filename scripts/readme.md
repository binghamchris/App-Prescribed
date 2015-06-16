# Script Files
These scripts are used to install and configure AppPrescribed.

## Files
- **15_umount_attachments.sh** is intended to be run inside an Elastic Beanstalk environment and unmounts the attachments EBS volume during the deployment of new version of the application.
- **99_app_setup.sh** is intended to be run inside an Elastic Beanstalk environment and performs the final configuration steps prior to the application being started.
- **ami-setup.sh** performs a scripted installation of the application intended to be run manually in a non-Elastic Beanstalk EC2 instance.