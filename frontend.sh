#!/bin/bash

component=frontend
logFile=/tmp/$component.log
# Common function to print the status of the component
stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m"    
    else
        echo -e "\e[31m Failure \e[0m"    
    fi
}

echo -n "Installing Nginx:"
dnf install nginx -y     &>> $logFile
stat $?


echo -n "Starting Nginx:"
systemctl enable nginx   &>> $logFile
systemctl start nginx    &>> $logFile
stat $?

echo -n "Clearning Old $component Content:"
rm -rf /usr/share/nginx/html/* 
stat $?

echo -n "Downloading $component Content:"
curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/frontend.zip &>> $logFile
stat $?

echo -n "Extracting $component Content:"
cd /usr/share/nginx/html 
unzip -o /tmp/$component.zip &>> $logFile
stat $?

echo -n "Restarting Nginx:"
systemctl restart nginx 
stat $?

echo -n "*****  $component Execution Completed  *****"