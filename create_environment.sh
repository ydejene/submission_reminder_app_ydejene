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
touch "$DirName/modules/functions.sh"
touch "$DirName/assets/submissions.txt"
touch "$DirName/config/config.env"
touch "$DirName/startup.sh"

echo "The files have been created successfully."
echo "-------------------------------------------------"

#apppending the datas into the files created
echo '#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file' >> "$DirName/app/reminder.sh"

echo '#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}' >> "$DirName/modules/functions.sh"

echo 'student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted' >> "$DirName/assets/submissions.txt"

echo '# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2' >> "$DirName/config/config.env"

#updating the permissions of all files with the .sh extension to executable
find "$DirName" -type f -name "*.sh" -exec chmod +x {} \;

echo "the data has been appended and the files permission has been updated"


