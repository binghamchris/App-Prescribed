# Elastic Beanstalk Customisation Files
These files provide Elastic Beanstalk with instructions for configuring the environment for App Prescribed, and are to be included in the application zip file/tarball.
They are processed in alphabetical order.

## Files
- **000-beanstalk-options.config** sets general Elastic Beanstalk environment options.
- **001-mongo-repo.config** installs an additional yum repository containing a version of MongoDB complied to work on Amazon Linux.
- **002-packages.config** installs all additional packages needed for the application to run.
- **003-files.config** writes configuration and script files required before the application is installed.
- **004-mount-ebs.config** creates and attaches EBS volumes for MongoDB and user-uploaded files and updates /etc/fstab.
- **005-services.config** configures MongoDB to run and both MongoDB and Nginx to restart if their configuration is updated and configures the firewall.