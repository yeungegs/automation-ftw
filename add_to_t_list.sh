#!/usr/bin/env bash
# script to add new batch of Holberton students to Twitter list
# takes two args from standard input
# Arg1 - sourcefile of student page saved from intranet (hint: use curl)
# Arg2 - four digits to right of name (example: "Betty Holberton - 0116" enter 0116

# all the pretty colors
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green

FILE=$1
BATCH=$2
REGEX="\[0-9]{4}\\"
LIST=$3

if [ $# -ne 3 ]; then
    echo "Script requires three arguments - add_to_twitter_list.sh sourcefile batch twitter-list-name"
    exit
fi

if [ -f $1 ]; then
    echo "Sourcefile exists"
else
    echo "Sourcefile not found"
    exit
fi

if [[ $BATCH =~ $REGEX ]]; then
    echo "$BATCH matches $REGEX"
else
    echo "$BATCH does not match $REGEX"
fi

t whoami
if [ $? -ne 0 ]; then
    echo "Please set up t with your Twitter account: github/sferik/t"
else
    echo "Twitter account set up with t"
fi

t list information $LIST
if [ echo $? -eq 0 ]; then
    cat $FILE | grep -A25 $BATCH | grep twitter.com | sed 's/.*twitter.com\///' | sed 's/">//' | sed 's/@//' | sort > list
    PS3="Adding the following users to Twitter list:"
    cat list
    t list add $LIST $(cat list | tr '\n' ' ')
    rm list
fi
