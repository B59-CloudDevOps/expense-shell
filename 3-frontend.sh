#!/bin/bash

component=frontend

source common.sh                                                         # Importing common functions from common.sh
echo -n "Installing Nginx:"
dnf install nginx -y     &>> $logFile
stat $?

echo -n "Configuring Proxy:"
cp expense.conf /etc/nginx/default.d/expense.conf  &>> $logFile
stat $?

echo -n "Clearning Old $component Content:"
rm -rf /usr/share/nginx/html/* 
stat $?

echo -n "Downloading $component Content:"
curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/$component.zip &>> $logFile
stat $?

echo -n "Extracting $component Content:"
cd /usr/share/nginx/html 
unzip -o /tmp/$component.zip &>> $logFile
stat $?

echo -n "Restarting Nginx:"
systemctl enable nginx   &>> $logFile
systemctl restart nginx 
stat $?

echo -n "*****  $component Execution Completed  *****"