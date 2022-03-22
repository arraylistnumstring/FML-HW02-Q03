"""
    Plot error in training data vs. d.
"""

__author__ = "Brian H. Chiang"

import matplotlib.pyplot as pyplot
import numpy
import os.path
import sys

MAX_K = 9

def main():

    # Check for correct usage
    if len(sys.argv) < 2:
        print("Usage: training-sample-error-histogram-plotter.py input-file")
        sys.exit(1)

    # File existence errors
    if not os.path.exists(sys.argv[1]):
        print("Input file " + sys.argv[1] + " could not be found.")
        sys.exit(2)

    # Python's "wrapped" try-catch block equivalent statement/
    # error handler
    with open(sys.argv[1], encoding = "utf-8") as input_file:
        line = input_file.readline()

        split_ind = []
        train_errors = []
        test_errors = []

        line_ind_in_block = 0

        while line: # While line is not empty, i.e. there are lines to be read
            if line == "\n":
                split_ind.append(len(split_ind))
            else:
                curr_error = 1 - float(line)/100
                if line_ind_in_block == 0:
                    train_errors.append(curr_error)
                else:
                    test_errors.append(curr_error)
                line_ind_in_block += 1
                line_ind_in_block %= 2

            line = input_file.readline()

    input_file.close()

    # Negative width gives right-alignment
    pyplot.bar(split_ind, train_errors, width=-0.4, align="edge", label="Training error")
    pyplot.bar(split_ind, test_errors, width=0.4, align="edge", label="Testing error")

    pyplot.xlabel("Index of partition of training data used")
    pyplot.ylabel("Training error")

    # Places upper-left corner of legend at the given x,y coordinates, with floats
    # being fractions of the relevant dimension of the graph
    pyplot.legend(loc="upper left", bbox_to_anchor=(.75, 1.15))

    pyplot.show()
# End main()


if __name__ == "__main__":
    main()
