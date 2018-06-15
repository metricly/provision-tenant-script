# provision-tenant-script
Script to provision a new tenant account and install pre-configured package.  The script will also return the datasource IDs, so the agents can be deployed via automation tools/scripts. 

Required: You need to have a Metricly account to run the script.

Instructions:
1. The script will check to make sure all the fields in the configureMetricly.cfg have been updated.  This cfg file is required to run the script.

2. To run the script provide your username/password for Metricly.

3. You will need to set the password for the NEW tenant account.  Passwords can be reset be the endusers.  No passwords are stored in the configuration file.
	
4. Currently the package install can be turned off/on.  The package name must be package.zip and needs to be stored in the same location as the script.

Note: Metricly support team will need to build your package today.  Contact Metricly support if you want to have a custom package created for your account.  https://www.metricly.com/support/api/packages
