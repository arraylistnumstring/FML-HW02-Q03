#!/bin/bash

# e() is exp() and l() is ln() for calculator bc
# To allow exponentiation by fractions and negative numbers, we use
#	x^n = exp(log(x^n)) = exp(n log(x))

# First command-line argument is the positive integer representing the maximal value of k, for
# C=3^k ranging from k \in [-max_k, max_k]

# Degree of polynomial kernel
d=1
while [ $d -le 5 ]
do
	# Single parentheses necessary around bc because double parentheses cause a syntax error
	C=$(bc -l <<< "3^3")
	# -t 1 : polynomial kernel
	# -d $d : degree d polynomial
	# -c $C : cost C
	# -v 5 : 5-fold cross-validation
	svm-train -t 1 -d $d -c $C -v 5 "data/prepped--binary/rescaled-testing" > \
		"question4-5-fold-cross-validation-data-cost-$C/polyn-degree-$d"
	echo d=$d run done
	((d++))
done
