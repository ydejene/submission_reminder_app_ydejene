#!/bin/bash
# asking for the user input to create the main directory
read -p "please enter your name: " Uname

#storing the directory name in a variable
DirName="submission_reminder_$Uname"

#validating if Uname is empty or not
if [[ -n "$Uname" ]]; then
	echo "the directory '$DirName' will be created."
	mkdir -p "$DirName"
	if [[ $? -eq 0 ]]; then 
		echo "Directory '$DirName' created successfully."
	else
		"Error: could not create directory '$DirName'."
		exit 1
	fi
else
	echo "Error: Please provide your name and try again"
	exit 1
fi

