# this file is used to define the common patterns and functions. This can be sourced in other scripts by using the below command
# source common.sh

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