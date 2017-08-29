#!/usr/bin/env bash
new_dir=0
source=0
tasks=0
ext=0
header=0
echo -n "Enter name of source file > "
read source


##############################################################
# grep for directory name of new project and assign variable #
##############################################################

new_dir=`grep -m 1 Directory $source | tr -d ' ' | sed 's/<[^>]*>//g' | sed 's/Directory://'`

##########################################################
# grep for number of tasks to create and assign variable #
##########################################################

tasks=`grep -a1 '<h4 class="task">' $source | tr -d ' ' | tail -n 1 | egrep -o '[0-9]{1,}'`


################################################################
# Make new project directory, then navigate into new directory #
# lastly specify where new files shoupld be created	       #
################################################################
mkdir $new_dir
cd $new_dir
files=../$new_dir/*

######################################################################
# create empty files for project - process source text for filenames #
######################################################################
grep "<li>File: <code>" ../$source | tr -d ' ' | sed 's/<li>File:<code>//; s/<\/code><\/li>//' | paste -s | xargs touch

#################################################
# prompt user to select from list of languages  #
# set extension, header and main file variables #
#################################################

PS3='Select language to be used: '
options=("C" "Python" "Bash" "Quit")
echo -n "are main files needed? y/n > "
read main
echo -n "should files be executable? y/n > "
read permission

select opt in "${options[@]}"
do
    case $opt in
	"C")
	    # prep header file for c projects
	    echo -n "is header needed? y/n > "
	    read header
	    if [ $header = y ]; then
		grep "<li>Prototype: <code>" ../$source | cut -c 24- | rev | cut -c 13- | rev >> header.h # next revision should process text for header file name
	    fi
	    ext=c
	    echo "C is fun!"
	    ;;
	"Bash")
	    if [ $permission = y ]; then
		for f in $FILES; do
		    chmod u+x $f
		    echo '#!/usr/bin/env bash\n# comment here\n' >> $f
		done
	    fi
	    ext=sh
	    echo "Automate that shit!"
	    ;;
	"Python")
	    if [ $permission = y ]; then
		for f in $FILES; do
		    echo '#!/usr/bin/python\n"""docstring"""\n' >> $f
		done
	    fi
	    ext=py
	    echo "Python is cool!"
	    ;;
	"Quit")
	    break
	    ;;
	*) echo 'invalid option - only enter the number of your choice!';;
    esac
done

# prep README with list of files and description of tasks
grep "<li>File: <code>" ../$source | tr -d ' ' | sed 's/<li>File:<code>//; s/<\/code><\/li>//' >> README.md
sed -n -e '/Task Body/,/pre/ p' ../$source | grep -v "pre" >> README.md
cat ~/automation-ftw/template_README.md >> README.md

# prep main files if requested
if [ $main = y ]
then
    for NUM in `seq 0 1 $tasks`
    do
	touch $NUM-main.$ext
    done
fi

echo '  ##############'
echo '  #  ___       #'
echo '  # |     |    #'
echo '  # | +-  |    #'
echo '  # |   | |    #'
echo '  #  ---   --- #'
echo '  #        ___ #'
echo '  # |   | |    #'
echo '  # |-+-| |-+- #'
echo '  # |   | |    #'
echo '  #            #'
echo '  ##############'

