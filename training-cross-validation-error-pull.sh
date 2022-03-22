#!/bin/bash

# For coordinating the concatenation of cross-validation accuracy across different split files

file_prefix="question3-5-fold-cross-validation-data"

# Clean destination folder before running
rm -f $file_prefix/*

# First command-line argument is the positive integer representing the maximal value of k
# for C=3^k ranging from k \in [-max_k, max_k]
max_k=$1

# While loops necessary because variables aren't subsituted into filename properly otherwise

# Degree of polynomial kernel
d=1
while [ $d -le 5 ]
do
	k=-$max_k

	# Single parentheses necessary around bc because double parentheses cause a syntax error
	C=$(bc -l <<< "3^$k")

	while [ $k -le $max_k ]
	do
		output_file="$file_prefix/polyn-degree-$d-k-$k"
		for i in {0..4}
		do
			input_file="$file_prefix-split/polyn-degree-$d-k-$k-split-$i"
			# Keep everything after the first "=" that is also before the first "%"
			grep -n "Cross Validation Accuracy" $input_file | cut --complement -d "=" -f 1 | cut -d "%" -f 1 >> $output_file
		done
		((k++))
		C=$(bc -l <<< "3^$k")
	done
	((d++))
done
