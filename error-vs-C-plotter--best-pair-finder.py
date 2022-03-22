"""
    Plot error in training data vs. log_3(C) and find best pair (C^*, d^*).
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
        print("Usage: d-C-plotter--best-pair-finder.py input-file")
        sys.exit(1)

    # File existence errors
    if not os.path.exists(sys.argv[1]):
        print("Input file " + sys.argv[1] + " could not be found.")
        sys.exit(2)

    min = numpy.inf
    k_star = numpy.inf
    d_star = numpy.inf

    # Python's "wrapped" try-catch block equivalent statement/
    # error handler
    with open(sys.argv[1], encoding = "utf-8") as input_file:
        line = input_file.readline()

        k = -MAX_K
        d = 1
        data_matrix = [([], [])] # Data put in arrays by polynomial degree, with the first array in the tuple containing the k value and the second containing the error as 

        while line: # While line is not empty, i.e. there are lines to be read
            if line == "\n":
                d += 1
                data_matrix.append(([],[]))
                k = -MAX_K
            else:
                curr_error = 1 - float(line)/100
                data_matrix[-1][0].append(k)
                data_matrix[-1][1].append(curr_error)
                # Find k*, d*
                if curr_error < min:
                    min = curr_error
                    d_star = d
                    k_star = k
                k += 1

            line = input_file.readline()

    input_file.close()

    print(f"d* = {d_star}\nk* = {k_star}\nC* = {3**k_star}")

    d = 1

    for tuple in data_matrix:
        pyplot.plot(tuple[0], tuple[1], label=f"d={d}")
        d += 1

    pyplot.xlabel("k = log_3(C)")
    pyplot.ylabel("Training error")

    pyplot.legend()

    pyplot.show()
# End main()


if __name__ == "__main__":
    main()
