#!/bin/sh
source=0
tasks=0
header=0

echo -n "Enter name of source file > "
read source
echo -n "Enter number of mandatory tasks > "
read tasks
echo -n "is header needed? y/n > "
read header

grep "<li>File: <code>" $source | cut -c 19- | rev | cut -c 13- | rev | paste -s | xargs touch
grep "<li>File: <code>" $source | cut -c 19- | rev | cut -c 13- | rev >> README.md

if [ $header = y ]
then
    grep "<li>Prototype: <code>" $source | cut -c 24- | rev | cut -c 13- | rev >> header.h
else
    echo "no header file for you!"
fi    

for NUM in `seq 0 1 $tasks`
do
    $NUM-main.py
done
