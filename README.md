# automation-ftw

### Project overview
These scripts are created to automating daily tasks. As I learn more about shell script functionality, I will update and retool scripts. 

### Usage
[new_project.sh](./new_project.sh)
Description - this script creates directory for new project, outputs list of files to README and creates empty project files and  main files. When run, it reads the following from user input:
* name of project directory
* name of source file (see restrictions below)
* number of mandatory tasks
* is header needed?

#### Restrictions
Current version only works as expected with certain pre-requisites in place:
* Current working directory is project repo
* Project html has been saved to file located in current working directory
