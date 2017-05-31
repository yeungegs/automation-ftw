#!/bin/sh
new_dir=0
source=0
tasks=0
ext=0
header=0
echo -n "Enter name of new directory > "
read new_dir
echo -n "Enter name of source file > "
read source
echo -n "Enter number of mandatory tasks > "
read tasks
echo -n "Enter file extension for main files (don't include '.') > "
read ext
echo -n "is header needed? y/n > "
read header

mkdir $new_dir
cd $new_dir
files=../$new_dir/*

grep "<li>File: <code>" ../$source | cut -c 19- | rev | cut -c 13- | rev | paste -s | xargs touch
for f in $files
do
    echo "#!/usr/bin/python3" >> $f
done

grep "<li>File: <code>" ../$source | cut -c 19- | rev | cut -c 13- | rev >> README.md

if [ $header = y ]
then
    grep "<li>Prototype: <code>" ../$source | cut -c 24- | rev | cut -c 13- | rev >> header.h
else
    echo "no header file for you!"
fi    

for NUM in `seq 0 1 $tasks`
do
    touch $NUM-main.$ext
done
