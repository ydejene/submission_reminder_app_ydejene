#!/bin/bash
#---- copilot_shell_script.sh ----

#ask the user for an assignment name
read -p "Please enter an assignment name: " assignName

#locating the main folder that is setup by create_environment.sh safley redirect error messages if any
DIR=$(ls -d submission_reminder_* 2>/dev/null)

#check if it  exists 
if [[ -z "$DIR" ]]; then
	echo "The directory submission_reminder_* does not exist, make sure you run the create_environment.sh first"
	exit 1
fi

CONFIG="$DIR/config/config.env"
if [[ ! -f "$CONFIG" ]]; then
	echo "Error: $CONFIG not found in $DIR." >&2
	exit 1
fi

#replacing current name in config/config.env on the ASSIGNMENT value (row 2)
 sed -i "s|ASSIGNMENT=.*|ASSIGNMENT=\"$assignName\"|" "$CONFIG"
 echo "Updated the ASSIGNMENT in $CONFIG to \"$assignName\""

#Locate and re-run the startup.sh file
startup="$DIR/startup.sh"
if [[ ! -x "$startup" ]]; then
	echo "Error: Cannot find executable $startup" >&2
	exit 1
fi

echo "-------------------------------"

echo "Running the startup.sh file"
bash $startup
