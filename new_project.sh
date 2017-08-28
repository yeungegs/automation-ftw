#!/usr/bin/env bash
new_dir=0
source=0
tasks=0
ext=0
header=0
echo -n "Enter name of source file > "
read source

#echo -n "Enter name of new directory > "
#read new_dir
#make directory for new project
new_dir=`grep -m 1 Directory $source | tr -d ' ' | sed 's/<[^>]*>//g' | sed 's/Directory://'`

#echo -n "Enter number of mandatory tasks > "
#read tasks
# grep for number of tasks
tasks=`grep -a1 '<h4 class="task">' 301 | tr -d ' ' | tail -n 1 | egrep -o '[0-9]{1,}'`
echo -n "Enter file extension for main files (don't include '.') > "
read ext
echo -n "is header needed? y/n > "
read header
echo -n "are main files needed? y/n > "
read main
echo -n "should files be executable? y/n > "
read permission
echo -n "do you need a shebang? bash/py > "
read shebang

mkdir $new_dir
cd $new_dir
files=../$new_dir/*

#create empty files for project
# old version of this script used this set of commands to parse and create files:
# grep "<li>File: <code>" ../$source | cut -c 28- | rev | cut -c 13- | rev | paste -s | xargs touch
# updated script uses sed to more precisely parse html to find filenames
grep "<li>File: <code>" ../$source | tr -d ' ' | sed 's/<li>File:<code>//; s/<\/code><\/li>//' | paste -s | xargs touch

#echo shebang into first line of new files
for f in $files; do
    if [ $permission = y ]
       then chmod u+x $f
    fi

    if [ $shebang = bash ]
       then echo '#!/bin/bash' >> $f
    fi

    if [ $shebang = py ]
       then echo '#!/usr/bin/python' >> $f
    fi
done

# prep README with list of files and description of tasks
grep "<li>File: <code>" ../$source | tr -d ' ' | sed 's/<li>File:<code>//; s/<\/code><\/li>//' >> README.md
sed -n -e '/Task Body/,/pre/ p' ../$source | grep -v "pre" >> README.md

# prep header file for c projects
if [ $header = y ]
then
    grep "<li>Prototype: <code>" ../$source | cut -c 24- | rev | cut -c 13- | rev >> header.h
else
    echo "no header file for you!"
fi    

# prep main files if requested
if [ $main = y ]
then
    for NUM in `seq 0 1 $tasks`
    do
	touch $NUM-main.$ext
    done
fi
echo -n "gl hf xD"
