#!/bin/bash

: << disclaimer

This is just for educational purpose
disclaimer

read -p "Enter age: " age

if [[ $age -ge 18 ]]
then
	echo "User is eligible for driving license"
else
	echo "User is NOT eligble"
fi

: << numeric

For numeric comparisons bash programmers prefer

if (( age >= 18 ))
then
	echo "Eligible for driving license"
fi
numeric
