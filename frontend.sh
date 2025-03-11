#!/bin/bash

echo -n "Installing Nginx:"
dnf install nginx -y     &>> /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"    
else
    echo -e "\e[31m Failure \e[0m"    
fi

echo -n "Starting Nginx:"
systemctl enable nginx   &>> /tmp/frontend.log
systemctl start nginx    &>> /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

# rm -rf /usr/share/nginx/html/* 
# curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
# cd /usr/share/nginx/html 
# unzip /tmp/frontend.zip
# systemctl restart nginx 
# set-hostname frontend