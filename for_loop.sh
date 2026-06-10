#!/bin/bash

# for and while loops

for (( i=1; i<=5; i++ ));
do
	echo "Hello"
done

# using arguments

# 1 is for folder name
# 2 is start range
# 3 is for end range

for (( i=$2; i<=$3; i++ ));
do
	mkdir "$1$i"
done
