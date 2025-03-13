#!/bin/bash

component=mysql
source common.sh                                        # Importing common functions from common.sh
if [ -z $1 ]; then 
    echo -e "\e[31m Please provide the password to set for root user \e[0m"
    echo -e "Example usage: \n\t \e[35m sudo bash $0 password \e[0m"
    exit 1
fi
 
echo -n "Installing $component Server:"
dnf install mysql-server -y  &>> $logFile
stat $? 

echo -n "Starting $component Server:"
systemctl enable mysqld  &>> $logFile
systemctl start  mysqld  &>> $logFile
stat $? 

echo -n "Configuring $component root password:"
mysql_secure_installation --set-root-pass $1 &>> $logFile
stat $? 

echo -n "*****  $component Execution Completed  *****"