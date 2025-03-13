# expense-shell
This repo contains the automation of expense project using bash scripting

Golden Rules to be followed when automating the manual process
    1) Code should be DRY 
    2) Logs should not be displayed on the screen ( Y )
    3) It should always show whether the step is succesful or not  ( Y )
    4) When you rerun the script from the second time on the same server, it should be qualified ( Y )

### Area's of improvements:
    1) If condition is used multiple times, let's try to put that as a function and call that as needed.

### DRY (Don't Repeat Yourself) and WET (Write Everything Twice) are software engineering principles that describe how to write code. DRY code is preferred because it's easier to maintain and scale. 
> DRY code is achieved by abstracting out common functionality into functions, classes, or modules. WET code is achieved by copying and pasting blocks of code. 

NFR:
    > Code should be dry
    > Passwords should not be hardcoded
    > Re-run of code should work.
    > 14

If a function is defined outside the file, then we need to source the file
    # source fileName.sh

> We automated the Configuration Management and some of the manual actions are:
    Mysql:
        1) Created server manually from UI 
        2) Logged on to server 
        3) Made a git clone 
        4) Executed the script manually

    Backend:
        1) Created server manually from UI 
        2) Logged on to server 
        3) Made a git clone 
        4) Executed the script manually

    Frontend:
        1) Created server manually from UI 
        2) Logged on to server 
        3) Made a git clone 
        4) Executed the script manually