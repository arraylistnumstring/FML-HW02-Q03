# bc2611-FMach-HW02-Q03

Requires use of the `libsvm` library.

## Process

- Reformat data so that `abalones` is split as indicated in the homework assignment into training and testing data and is in `libsvm` format (please see the Notes section below for more specifics).

### Question 3

- Run
	```
		# Split data into 5 files, letting each line be placed in a given file approximately uniformly at random using numpy's "pseudo-random" number generator 
		python rand-row-split.py 5 data/prepped--binary/rescaled-training data/prepped--binary/split-training-

		# Run training for -9 <= k <= 9 and 1 <= d <= 5
		./question3-training.sh 9

		# Extract cross-validation accuracy from training output, grouped by split and clean data so it is ready to be fed into Python program
		./training-cross-validation-error-pull.sh 9
	```

- Reformat `question3-error-data` so that it consists purely of the values n provided by "Cross-Validation Accuracy = n%"

- Run
	```
		# Produce training error vs. C plot and best pair (C*, d*)
		python error-vs-C-plotter--best-pair-finder.py question3-error-data
	```

### Question 4

- Run
	```
		# Run testing for 1 <= d <= 5 using C*
		./question4-training.sh

		# Extract cross-validation accuracy from testing output
		./testing-cross-validation-error-pull.sh question4-5-fold-cross-validation-data-cost-27/polyn-degree- question4-error-data
	```

- Reformat `question4-error-data` so that it consists purely of the values n provided by "Cross-Validation Accuracy = n%"

- Run
	```
		# Produce testing error vs. d plot
		python error-vs-d-plotter.py question4-error-data

		# Extract total number of support vectors from testing output and clean file so it is ready to be fed into Python program
		./support-vector-number-pull.sh question4-5-fold-cross-validation-data-cost-27/polyn-degree- question4-support-vectors

		# Produce average number of support vectors vs. d plot
		python support-vectors-vs-d-plotter.py question4-support-vectors
	```

## Question 5

- Run
	```
		# Run training and testing in pairs
		./question5-training-testing-pairs.sh
	```


## Notes

Index of Class = # Rings

libsvm requirements:

- Data format for each line must be
	```
		<label> <index_1>:<value_1> ... <index_n>:<value_n>
	```
	for `<label>` defining the class of the data, `<index_i>` = i and `<value_i>` a real number

- Because the class of each entry is the number of rings, which is the last entry in the original data, the data in each row has been re-ordered so that the number of rings has been moved to become the first entry in each row, with all other data left in their original position.

- Because `<value_i>` must be a real number, and one of the data fields is "Sex," with values F, I (for infant) and M, use the mapping {(F, -1), (I, 0), (M, 1)}.
