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

echo -n "Clearning Old Frontend Content:"
rm -rf /usr/share/nginx/html/* 
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Downloading Frontend Content:"
curl -o /tmp/frontend.zip https://expense-web-app.s3.amazonaws.com/frontend.zip
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Extracting Frontend Content:"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>> /tmp/frontend.log
if [ $? -eq 0 ]; then 
    echo -e "\e[32m Success \e[0m"
else
    echo -e "\e[31m Failure \e[0m"
fi

echo -n "Restarting Nginx:"
systemctl restart nginx 

echo -n " *****  Frontend Execution Completed  *****"