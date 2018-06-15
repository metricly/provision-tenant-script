# provision-tenant-script
Script to provision a new tenant account and install pre-configured package.  The script will also return the datasource IDs, so the agents can be deployed via automation tools/scripts. 

Required: You need to have a Metricly account to run the script.

Instructions:
1. Create a new directory, copy setupMetricly.sh and configureMetricly.cfg into the new directory.  If you have a pre-built Metricly package, make sure it is named package.zip and place it in the same directory.

2. Now you can run the script.  The script will check to make sure all the fields in the configureMetricly.cfg have been updated.  This cfg file is required to run the script.

3. To run the script provide your username/password for Metricly.

4. You will need to set the password for the NEW tenant account.  Passwords can be reset be the endusers.  No passwords are stored in the configuration file.
	
5. A new file will be created in the same location as the script called listDatasources.json.  This file will have the IDs required to install the agents.  The file can be used to help script the agent deployments.

6. Currently the package install can be turned off/on.  The package name must be package.zip and needs to be stored in the same location as the script.

Note: Metricly support team will need to build your package today.  Contact Metricly support if you want to have a custom package created for your account.  https://www.metricly.com/support/api/packages

Note: Any issues will be writen into a file called logFile.txt.  This file will be created in the same location as the script.
