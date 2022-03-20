# bc2611-FMach-HW02-Q03

Requires use of the `libsvm` library.

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
