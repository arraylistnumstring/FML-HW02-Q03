"""
    Plot error in training data vs. log_3(C) and find best pair (C^*, d^*).
"""

__author__ = "Brian H. Chiang"

import matplotlib.pyplot as pyplot
import numpy
import os.path
import sys

MAX_K = 9
POLYN_DEG = 5

def main():

    # Check for correct usage
    if len(sys.argv) < 2:
        print("Usage: error-vs-C-plotter--best-pair-finder.py input-file-prefix")
        sys.exit(1)

    min_err = numpy.inf
    k_star = numpy.inf
    d_star = numpy.inf

    # Elements will have form of ([], [], []), with each tuple representing a polynomial
    # degree; the first array in the tuple contains the k value, the second contains the
    # mean and the third contains the standard deviation
    data_matrix = []

    # Calculate the average and standard deviation of the cross-validation accuracies for
    # each polynomial degree d
    for d in range(1, POLYN_DEG + 1):

        data_matrix.append( ([], [], []) )

        # Calculate the average and standard deviation of the entries of each file
        for k in range(-MAX_K, MAX_K + 1):

            curr_file = sys.argv[1] + f"{d}-k-{k}"

            # File existence errors
            if not os.path.exists(curr_file):
                print("Input file " + curr_file + " could not be found.")
                sys.exit(2)

            # Array for storing data from current file
            curr_file_data = []

            # Python's "wrapped" try-catch block equivalent statement/
            # error handler
            with open(curr_file, encoding = "utf-8") as input_file:
                line = input_file.readline()

                while line: # While line is not empty, i.e. there are lines to be read
                    curr_file_data.append(1 - float(line)/100)

                    line = input_file.readline()

            input_file.close()

            curr_avg_err = numpy.mean(curr_file_data)

            data_matrix[-1][0].append(k)
            data_matrix[-1][1].append(curr_avg_err)
            data_matrix[-1][2].append(numpy.std(curr_file_data))

            # Find k*, d*
            if curr_avg_err < min_err:
                min_err = curr_avg_err
                d_star = d
                k_star = k
        # End for loop over k
    # End for loop over d

    print(f"d* = {d_star}\nk* = {k_star}\nC* = {3**k_star}")

    d = 1

    for tuple in data_matrix:
        pyplot.errorbar(tuple[0], tuple[1], tuple[2], label=f"d={d}")
        d += 1

    pyplot.xlabel("k = log_3(C)")
    pyplot.ylabel("Training error")

    pyplot.legend()

    pyplot.show()
# End main()


if __name__ == "__main__":
    main()
