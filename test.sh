#!/bin/sh
header=0

echo -n "is header needed? y/n > "
read header

if [ $header = y ]
then
    echo "we will create a header file"
else
    echo "no header file for you!"
fi    
