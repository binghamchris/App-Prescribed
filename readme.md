# Roche App Prescribed AWS Architecture
This repo contains the customisation files required to instantiate an installtion of App Prescribed on AWS.
These files are desgined for use with the 64bit Amazon Linux 2015.03 v1.4.1 AMI in Elastic BeanStalk.

## Files
- .ebextensions/001-enable-epel.config
  Enables the EPEL repo for package installation.

- .ebextensions/002-mount-ebs.config
  Mounts a pre-existing EBS volume within the Elastic Beanstalk managed instance.

- .ebextensions/003-packages.config
  Installs package pre-requisites via yum.
