#!/bin/bash
# asking for the user input to create the main directory
read -p "please enter your name: " Uname

#storing the directory name in a variable
DirName="submission_reminder_$Uname"

#validating if Uname is empty or not
if [[ -n "$Uname" ]]; then
	echo "Creating the directory '$DirName' ..."
	mkdir -p "$DirName"
	if [[ $? -eq 0 ]]; then 
		echo "Directory '$DirName' has been created successfully."
	else
		"Error: could not create directory '$DirName'."
		exit 1
	fi
else
	echo "Error: Please provide your name and try again"
	exit 1
fi

echo "-------------------------------------------------"

#creating the sub-directories 
echo "Creating the sub-directories ..."
mkdir -p "$DirName/app"
mkdir -p "$DirName/modules"
mkdir -p "$DirName/assets"
mkdir -p "$DirName/config"

echo "sub-directories have been created successfully."
echo "-------------------------------------------------"
#creating the files needed
echo "creating the files under their respective directories ..."
touch "$DirName/app/reminder.sh"
touch "$DirName/modules/fuctions.sh"
touch "$DirName/assets/submissions.txt"
touch "$DirName/config/config.env"

echo "The files have been created successfully."

