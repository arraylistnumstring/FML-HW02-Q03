#!/bin/bash

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
