#!/bin/bash

# For taking lines of data files (prefix given by 1st command-line argument, $1) containing
# "Cross Validation Accuracy" and appending to an output file (given by 2nd command-line
# argument, $2)

# Clean destination file before running
rm -f $2

for d in {1..5}
do
	echo >> $2
	filenames="$1$d*"
	for file in $filenames
	do
		# Keep everything after the first "=" that is also before the first "%"
		grep -n "Cross Validation Accuracy" $file | cut --complement -d "=" -f 1 | cut -d "%" -f 1 >> $2
	done
done
