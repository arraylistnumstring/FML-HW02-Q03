#!/bin/bash

# For training data (question 3).

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
		#	x^n = exp(log(x^n)) = exp(n log(x))

		# Single parentheses necessary around bc because double parentheses cause a syntax error
		C=$(bc -l <<< "e($k*l(3))")
		for i in {0..4}
		do
			# -t 1 : polynomial kernel
			# -d $d : degree d polynomial
			# -c $C : cost C
			# -v 5 : 5-fold cross-validation
			svm-train -t 1 -d $d -c $C -v 5 "data/prepped--binary/split-training-$i" > \
				"question3-5-fold-cross-validation-data-split/polyn-degree-$d-cost-$C-split-$i"
			# -e enables interpretation of backslash escapes
			echo -e "\t\tsplit-$i run done"
		done
		echo -e "\tC=$C run done"
	done
	echo "d=$d run done"
done
