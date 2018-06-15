# provision-tenant-script
Create new tenant, deploy packages, and retrieve datasource IDs 

Overview: Script to provision a new tenant account and install pre-configured package

Required: You need to have a Metricly account to run the script.

Note: Metricly will need to build the package today per support team ticket

Instructions:
1. The script will check to make sure all the fields in the configureMetricly.cfg have been updated.  
	This cfg file is required to run the script

2. To run the script provide your username/password for Metricly

3. You will need to set the password for the NEW tenant account.  
	Do not want the password stored in the cfg file

4. Currently the package install can be turned off/on.  The package name is currently hardcoded (package.zip) and needs to be stored in the same location as the script.
