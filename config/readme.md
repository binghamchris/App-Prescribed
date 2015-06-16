# AppPrescribed Configuration Files
These files contain the configuration data required for the pilot installation of the App Prescribed to run.
NB: All security-sensitive data has been replaced with the string "xxx". All occurrences of this string should be replaced with correct data prior to using the application.

## Files
- **admin.js** configures the initial administer account in the application.
- **authorized_keys** the public SSH keys to be granted access to the application's EC2 instances
- **config.json** configures all general options in the application.
- **pilot.appprescribed.com.conf** configures Nginx to act as a reverse proxy for the application's various interfaces.