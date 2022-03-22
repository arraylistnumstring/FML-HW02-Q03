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
        print("Usage: error-vs-d-plotter.py input-file")
        sys.exit(1)

    # File existence errors
    if not os.path.exists(sys.argv[1]):
        print("Input file " + sys.argv[1] + " could not be found.")
        sys.exit(2)

    # Python's "wrapped" try-catch block equivalent statement/
    # error handler
    with open(sys.argv[1], encoding = "utf-8") as input_file:
        line = input_file.readline()

        d = [1]
        errors = []

        while line: # While line is not empty, i.e. there are lines to be read
            if line == "\n":
                d.append(len(d) + 1)
            else:
                curr_error = 1 - float(line)/100
                errors.append(curr_error)

            line = input_file.readline()

    input_file.close()

    pyplot.plot(d, errors)

    pyplot.xlabel("Polynomial kernel degree d")
    pyplot.ylabel("Training error")

    pyplot.show()
# End main()


if __name__ == "__main__":
    main()
