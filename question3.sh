#!/bin/bash

# e() is exp() and l() is ln() for calculator bc
# To allow exponentiation by fractions and negative numbers, we use
#	x^n = exp(log(x^n)) = exp(n log(x))

# Degree of polynomial kernel
d=1
while [ $d -le 5 ]
do
	k=-3

	# Single parentheses necessary around bc because double parentheses cause a syntax error
	C=$(bc -l <<< "e($k*l(3))")
	while [ $k -le 3 ]
	do
		svm-train -t 1 -d $d -c $C -v 5 data/prepped/rescaled-training
		((k++))
		C=$(bc -l <<< "e($k*l(3))")
	done
	((d++))
done
