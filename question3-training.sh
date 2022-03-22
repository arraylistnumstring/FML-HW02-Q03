#!/bin/bash

# For training data (question 3)

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
		for i in {0..4}
		do
			# -t 1 : polynomial kernel
			# -d $d : degree d polynomial
			# -c $C : cost C
			# -v 5 : 5-fold cross-validation
			svm-train -t 1 -d $d -c $C -v 5 "data/prepped--binary/split-training-$i" > \
				"question3-5-fold-cross-validation-data-split/polyn-degree-$d-k-$k-split-$i"
			# -e enables interpretation of backslash escapes
			echo -e "\t\tsplit-$i run done"
		done
		echo -e "\tC=$C run done"
		((k++))
		C=$(bc -l <<< "3^$k")
	done
	echo "d=$d run done"
	((d++))
done
