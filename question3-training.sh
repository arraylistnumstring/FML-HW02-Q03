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
	max_k=$1
	k=-$max_k
	# Single parentheses necessary around bc because double parentheses cause a syntax error
	C=$(bc -l <<< "e($k*l(3))")
	while [ $k -le $max_k ]
	do
		# -t 1 : polynomial kernel
		# -d $d : degree d polynomial
		# -c $C : cost C
		# -v 5 : 5-fold cross-validation
		svm-train -t 1 -d $d -c $C -v 5 data/prepped/rescaled-training > \
			5-fold-cross-validation-data/polyn-degree-$d-cost-$C
		echo C=$C run done
		((k++))
		C=$(bc -l <<< "e($k*l(3))")
	done
	echo d=$d run done
	((d++))
done
