#!/bin/bash

# For testing data (question 4)

# Degree of polynomial kernel
d=1
k_star=7

while [ $d -le 5 ]
do

	# Single parentheses necessary around bc because double parentheses cause a syntax error
	C=$(bc -l <<< "3^$k_star")
	# -t 1 : polynomial kernel
	# -d $d : degree d polynomial
	# -c $C : cost C
	# -v 5 : 5-fold cross-validation
	svm-train -t 1 -d $d -c $C -v 5 "data/prepped--binary/rescaled-testing" > \
		"question4-5-fold-cross-validation-data-k-$k_star/polyn-degree-$d"
	echo d=$d run done
	((d++))
done
