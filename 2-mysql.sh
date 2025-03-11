#!/bin/bash

component=mysql
logFile=/tmp/$component.log
# Common function to print the status of the component
if [ $(id -u) -ne 0 ]; then 
    echo -e "\e[31m You should be root user to perform this script \e[0m"
    echo -e "Example usage: \n\t \e[35m sudo bash $0 \e[0m"
    exit 2
fi

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m"    
    else
        echo -e "\e[31m Failure \e[0m"    
    fi
}

echo -n "Installing $component Server:"
dnf install mysql-server -y  &>> $logFile
stat $? 

echo -n "Starting $component Server:"
systemctl enable mysqld  &>> $logFile
systemctl start  mysqld  &>> $logFile
stat $? 

echo -n "Configuring $component root password:"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $logFile
stat $? 

echo -n "*****  $component Execution Completed  *****"