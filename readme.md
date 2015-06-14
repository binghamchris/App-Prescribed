# Roche App Prescribed AWS Architecture
This repo contains the customisation files required to instantiate an installtion of App Prescribed on AWS.
These files are desgined for use with the 64bit Amazon Linux 2015.03 v1.4.1 AMI in Elastic BeanStalk, and are intended to create a non-redundant pilot environment.

## Files
- **.ebextensions** contains Elastic Beanstalk customisation files for including in the application zip file/tarball
- **config** contains sample configuration files which are deployed into the Elastic Beanstalk environment
- **scripts** contails script files for deploying the application