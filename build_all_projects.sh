#!/usr/bin/env bash
## declare an array variable
declare -a arr=(
    "0-positive_or_negative"
    "1-last_digit"
    "2-print_alphabet"
    "3-print_alphabt"
    "4-print_hexa"
    "5-print_comb"
    "6-print_comb2"
    "7-islower"
    "8-print_last_digit"
    "9-add"
    "10-print_line"
    "11-print_diagonal"
    "12-fizzbuzz")

## now loop through the above array
for i in "${arr[@]}"
do
   echo "$i"
   dotnet new console -o "$i"
   cd "$i"
   dotnet build
   mv Program.cs "$i".cs
   cd ../
done
