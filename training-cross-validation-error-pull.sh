#!/bin/bash

# For coordinating the concatenation of cross-validation accuracy across different split files

# First command-line argument is the positive integer representing the maximal value of k
# for C=3^k ranging from k \in [-max_k, max_k]
max_k=$1

# Degree of polynomial kernel
for d in {1..5}
do
	for k in {-$max_k..$max_k}
	do
		# e() is exp() and l() is ln() for calculator bc
        # To allow exponentiation by fractions and negative numbers, we use
        #       x^n = exp(log(x^n)) = exp(n log(x))

		# Single parentheses necessary around bc because double parentheses cause a syntax error
		C=$(bc -l <<< "e($k*l(3))")

		file_prefix="question3-5-fold-cross-validation-data/polyn-degree-$d-cost-$C"
		output_file="$file_prefix"
		for i in {0..4}
		do
			input_file="$file_prefix-split-$i"
			grep -n "Cross Validation Accuracy" $input_file | cut --complement -d "=" -f 1 >> $output_file
		done
	done
done
