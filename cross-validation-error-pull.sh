#!/bin/bash

# For taking last lines of data files (prefix given by 1st command-line argument, $1)
# and appending to an output file (given by 2nd command-line argument, $2)

for d in {1..5}
do
	filenames="$1$d*"
	for file in $filenames
	do
		tail -1 $file >> $2
	done
	echo >> $2
done
