#!/bin/bash
# prompting the user for their name
read -p "please enter your name: " Uname

#validating the user input
if [[ -z "$Uname" ]]; then
       echo  "Error: Name cannot be empty."
       exit 1
fi

DirName="submission_reminder_$Uname"
 
#Create the main directory, it handles failure as well
mkdir -p "$DirName" || { echo "Error: Could not create $DirName"; exit 1; } 
echo "Successfully created directory: $DirName"

#creating the sub-directories 
for sub in app modules assets config; do
	mkdir -p "$DirName/$sub" || { echo "Error: Could not create $sub"; exit 1; }
done
echo "Successfully created sub directories inside $DirName"

#creating the files and appendig data inside them
cat > "DirName/app/reminder.sh" << 'EOF'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

cat > "$DirName/modules/functions.sh" << 'EOF'
#!/bin/bash

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
}
EOF

cat > "$DirName/assets/submisssions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Elvis, Git, submitted
Gael, Shell Basics, not submitted
Eelaf, Shell Navigation, submitted
Yonas, Git, not submitted
Leslie, Shell Basics, submitted
EOF

cat > "$DirName/config/config.env" << EOF
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

cat > "DirName/startup.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")/app"
./reminder.sh
EOF

#updating the permissions of all files with the .sh extension to executable
find "$DirName" -type f -name "*.sh" -exec chmod +x {} \;
echo "executing permissions set for .sh scripts"

echo "--------------------------------------"
echo "Setup complete. Run: cd $DirName && ./startup.sh"
