#!/bin/bash
component=backend
appUser=expense
rootPass=$1
source common.sh                    # Importing common functions from common.sh
                                   
if [ -z $1 ]; then 
    echo -e "\e[31m Please provide the password to set for mysql root user \e[0m"
    echo -e "Example usage: \n\t \e[35m sudo bash $0 password \e[0m"
    exit 2
fi

echo -n "Installing NodeJS:"
dnf module disable nodejs -y    &>> $logFile
dnf module enable nodejs:20 -y  &>> $logFile
dnf install nodejs -y           &>> $logFile
stat $? 

echo -n "Creating Application User - $appUser :"

id $appUser &>> $logFile
if [ $? -eq 0 ]; then 
    echo -e "\e[33m User $appUser is already there, So not creating \e[0m :"
    echo -e "\t\t SKIPPING"
else
    useradd $appUser &>> $logFile
    mkdir /app &>> $logFile
    stat $? 
fi

echo -n "Downloading $component Content:"
curl -o /tmp/$component.zip https://expense-web-app.s3.amazonaws.com/$component.zip &>> $logFile
stat $?

echo -n "Configuring systemd service:"
cp backend.service /etc/systemd/system/backend.service
stat $? 

echo -n "Extracting $component Content:"
cd /app/
unzip -o /tmp/$component.zip &>> $logFile
stat $?

echo -n "Generating $component artifacacts"
npm install &>> $logFile
stat $?

echo -n "Comfiguring the permissions:"
chmod -R 755 /app && chown -R $appUser:$appUser /app
stat $?

echo -n "Installing $component client:"
dnf install mysql-server -y  &>> $logFile
stat $? 

echo -n "Injecting $component schema:"
mysql -h mysql.cloudapps.today -uroot -p$rootPass < /app/schema/backend.sql &>> $logFile
stat $? 

echo -n "Starting $component Service:"
systemctl daemon-reload  &>> $logFile
systemctl enable backend &>> $logFile
systemctl start backend  &>> $logFile
stat $? 

echo -n "*****  $component Execution Completed  *****"