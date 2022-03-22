"""
    Plot average number of support vectors vs. d.
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
        print("Usage: support-vectors-vs-d-plotter.py input-file")
        sys.exit(1)

    # File existence errors
    if not os.path.exists(sys.argv[1]):
        print("Input file " + sys.argv[1] + " could not be found.")
        sys.exit(2)

    # Python's "wrapped" try-catch block equivalent statement/
    # error handler
    with open(sys.argv[1], encoding = "utf-8") as input_file:
        line = input_file.readline()

        d = []
        avg_num_supp_vecs = []
        curr_num_supp_vecs = []

        while line: # While line is not empty, i.e. there are lines to be read
            if line == "\n":
                d.append(len(d) + 1)
                if len(curr_num_supp_vecs) > 0:
                    avg_num_supp_vecs.append(numpy.mean(curr_num_supp_vecs))
                    curr_num_supp_vecs = []
            else:
                curr_num_supp_vecs.append(float(line))

            line = input_file.readline()

    input_file.close()

    # Flush final mean number of support vectors to avg_num_supp_vecs
    avg_num_supp_vecs.append(numpy.mean(curr_num_supp_vecs))


    pyplot.plot(d, avg_num_supp_vecs)

    pyplot.xlabel("Polynomial kernel degree d")
    pyplot.ylabel("Average number of support vectors")

    pyplot.show()
# End main()


if __name__ == "__main__":
    main()
