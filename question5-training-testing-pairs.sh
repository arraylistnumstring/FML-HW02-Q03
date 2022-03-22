#!/bin/bash

# Degree of polynomial kernel
d=3
# Single parentheses necessary around bc because double parentheses cause a syntax error
C=$(bc -l <<< "3^3")

input_files="data/prepped--binary/split-training-"

for i in {0..4}
do
	# -t 1 : polynomial kernel
	# -d $d : degree d polynomial
	# -c $C : cost C
	# -v 5 : 5-fold cross-validation
	svm-train -t 1 -d $d -c $C -v 5 "$input_files$i"> \
		"question5-training-testing-error-cost-$C-degree-$d/"
done
