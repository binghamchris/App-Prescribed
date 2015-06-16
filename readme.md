# Roche AppPrescribed AWS Architecture
This repo contains the customisation files required to instantiate an installation of App Prescribed on AWS.
These files are designed for use with the 64bit Amazon Linux 2015.03 v1.4.1 AMI in Elastic BeanStalk, and are intended to create a non-redundant pilot environment.

## Files
- **.ebextensions** contains Elastic Beanstalk customisation files for including in the application zip file/tarball.
- **config** contains sample configuration files which are deployed into the Elastic Beanstalk environment.
- **docs** contains documentation for people using the code in this repository.
- **scripts** contains script files for deploying the application.