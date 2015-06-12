# Roche App Prescribed AWS Architecture
This repo contains the customisation files required to instantiate an installtion of App Prescribed on AWS.
These files are desgined for use with the 64bit Amazon Linux 2015.03 v1.4.1 AMI in Elastic BeanStalk, and are intended to create a non-redundant pilot environment.

## Files
### Active
These files are tested and known to be working.

- ami-setup.sh
  A bash script automating the setup of a single instance to serve *.pilot.appprescribed.com.
  This script was created as an intermediate step prior to further automation using AWS tools.

- pilot.appprescribed.com.conf
  The nginx virtual host configuration for serving *.pilot.appprescribed.com.

### Defunct
These files are included for reference only.

- .ebextensions/000-beanstalk-options.config
  Configures the Elastic Beanstalk environment.

- .ebextensions/001-mongo-repo.config
  Enables a repo containing MongoDB built for Amazon Linux.

- .ebextensions/002-mount-ebs.config
  Mounts a pre-existing EBS volume within the Elastic Beanstalk managed instance.

- .ebextensions/003-packages.config
  Installs package pre-requisites via yum.

- .ebextensions/mongodb.config
  Manages the mongod service.