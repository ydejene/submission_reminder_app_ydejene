#!/bin/bash
#ask the user for an assignment name
read -p "Please enter an assignment name: " assignName

#check if the config.env file exists 
env_file=$(find . -type f -name "config.env")

if [["env_file"]] ; then
	echo "The file config.env doesn't exist, make sure the file the file exists"
	exit 1

fi

#replacing current name in config/config.env on the ASSIGNMENT value (row 2)
 sed -i "s/ASSIGNMENT=./ASSIGNMENT=\"$assignName\"/" "env.file"

#Rerun the startup.sh file
startup= (find . -maxdepth 1 -type f -name "startup.sh")
echo "running the startup.sh file"
./$startup
