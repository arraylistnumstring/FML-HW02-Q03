#!/bin/bash

# For taking lines from data files (prefix given by 1st command-line argument, $1) that
# contain the desired keyword "Total nSV" and appending to an output file (given by 2nd
# command-line argument, $2)

for d in {1..5}
do
	filenames="$1$d*"
	for file in $filenames
	do
		grep -n "Total nSV" $file | cut --complement -d "=" -f 1 >> $2
	done
	echo >> $2
done
