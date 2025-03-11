#!/bin/bash

component=frontend
logFile=/tmp/$component.log
echo -n "Installing Nginx:"
dnf install nginx -y     &>> $logFile
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"    
else
    echo -e "\e[31m Failure \e[0m"    
fi

echo -n "Starting Nginx:"
systemctl enable nginx   &>> $logFile
systemctl start nginx    &>> $logFile
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Clearning Old $component Content:"
rm -rf /usr/share/nginx/html/* 
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Downloading $component Content:"
curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/frontend.zip &>> $logFile
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Extracting $component Content:"
cd /usr/share/nginx/html 
unzip -o /tmp/$component.zip &>> $logFile
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Restarting Nginx:"
systemctl restart nginx 

echo -n " *****  frontend Execution Completed  *****"