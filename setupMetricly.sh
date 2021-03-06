#!/bin/bash
# Script to setup new tenant account and provision package 

# Grab the configuration file and read in all the new tenant properties
. configureMetricly.cfg

# Check to see if the configuration file has been updated
if [ -z "$setEmail" ] || [ -z "$setFirstName" ] || [ -z "$setLastName" ] || [ -z "$setPhone" ] || [ -z "$setCompany" ]; then
echo "Please update the configureMetricly.cfg file.  It is required for this script to run"
exit 1
fi

# request username and password
# Metricly username and password required to invoke API 
read -p 'Enter Metricly Username: ' username
read -sp 'Enter Metricly Password: ' password
echo 'completed'

# Need to set the password for the new tenant account 
echo 'Please set the password for the new tenant account... '
read -sp 'Enter New Metricly Account Password: ' passwordNew
echo 'completed'

# Prompt to install package 
echo 'You can install a prebuilt package into the new tenant account... '
read -p 'Do you want to install the package type yes or no: ' installPackage

# set the endpoint
endpointAddress="https://app.netuitive.com/tenant/create"

echo "Started.  Please wait new account being created..."
#create new tenant account
curl -s -X POST -u $username:$password -F 'email='$setEmail -F 'password='$passwordNew -F 'fullName='$setFirstName $setLastName -F 'firstName='$setFirstName -F 'lastName='$setLastName -F 'phone='$setPhone -F 'company='$setCompany $endpointAddress >> logFile.txt
echo "A new tenant account has been created!"

#create new json file with all the datasource IDs for the new tenant account
#wait 10 second before calling the API to let the provision complete
echo "A new file called listDatasources_$setCompany.json is being created with IDs required to install the agents.  Wait 10 seconds..."
echo "................................................................................................................................"
sleep 10
curl -s -X GET -u $setEmail:$passwordNew https://api.app.metricly.com/datasources?includeElements=true >> listDatasources_$setCompany.json

#Pull the Windows and Linux API ID from the listDatasources file
IFS=$'\n'
DSarray=($(cat listDatasources_$setCompany.json | sed "s%[\"]%%g;s%type:%\ntype:%g" | grep "type:" | sed "s%,properties.*apiId% apiId%;s%,.*%%;s%type:%%"))

for DS in ${DSarray[@]}; do 
if printf %s\\n $DS | grep -qF "WINDOWS" ;
then echo "Copy the Windows apiID to install the agent: $DS"; fi
if printf %s\\n $DS | grep -qF "INFRASTRUCTURE" ;
then echo "Copy the Linux apiID to install the agent: $DS"; fi
done


if [ $installPackage == 'yes' ]; then
#wait 10 second before calling package endpoint with new credentials
echo "Completing account setup in 10 seconds..."
sleep 10

#provision package
echo "Start provisioning package"
curl -X POST -u $setEmail:$passwordNew https://api.app.metricly.com/packages/install -H 'content-type: multipart/form-data' -F file=@package.zip >> logFile.txt
else
    echo "No packages installed in new tenant account"
fi


echo "Script completed.  Check logFile.txt for any errors."
