submission reminder app
This is a simple Linux shell script application that reminds students of upcoming assignment deadlines.
It helps list students who haven’t submitted their assignments — with an automated directory setup and easy update system.

--> How to setup the app:
1, Clone the repository:
git clone https://github.com/<YourGitHubUsername>/submission_reminder_app_<YourGitHubUsername>.git
cd submission_reminder_app_<YourGitHubUsername>

2, Run the environment setup script:
./create_environment.sh

-This will ask for your name
-It will create a directory: submission_reminder_<YourName>
-It will automatically create required subfolders and files

--> How to run the app:
To run the app and display reminders:

cd submission_reminder_<YourName>
./startup.sh

--> How to Update the assignment:
Use the copilot script to change the assignment name:

./copilot_shell_script.sh
-It will prompt you for a new assignment name
-It will update config/config.env
-It will re-run the app automatically to show the reminders

Notes:
-No external dependencies
-Runs on any Linux shell (Ubuntu, WSL, macOS Terminal, etc.)
-Designed for easy student use
