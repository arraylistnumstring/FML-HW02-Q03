#!/bin/bash

# For comparing training and testing data results for C*, d* (question 5)

k_star=7

# While loops necessary because variables aren't subsituted into filename properly otherwise

# Degree of polynomial kernel
d_star=1
# Single parentheses necessary around bc because double parentheses cause a syntax error
C_star=$(bc -l <<< "3^$k_star")
for i in {0..4}
do
	output_file="question5-5-fold-cross-validation-data-polyn-degree-$d_star-k-$k_star/split-$i"
	# -t 1 : polynomial kernel
	# -d $d : degree d polynomial
	# -c $C : cost C
	# -v 5 : 5-fold cross-validation
	svm-train -t 1 -d $d_star -c $C_star -v 5 "data/prepped--binary/split-training-$i" > $output_file
		
	echo >> $output_file
	
	svm-train -t 1 -d $d_star -c $C_star -v 5 "data/prepped--binary/rescaled-testing" >> $output_file
done
