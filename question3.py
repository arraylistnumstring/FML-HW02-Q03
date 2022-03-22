"""
    Split data randomly into n files, assuming one entry of data per row.
"""

__author__ = "Brian H. Chiang"

import numpy
import os.path
import sys

def main():

    # Check for correct usage
    if len(sys.argv) < 4 or not sys.argv[1].isdigit:
        print("Usage: rand-row-split.py n input-file output-file-prefix [-f]\n" +
                "n : Number of files to split input rows into\n" +
                "input-file : Name of file from which rows are sourced\n" +
                "output-file-prefix : Prefix of filenames to which output " +
                    "should be written\n" +
                "-f : (optional) Overwrite any existing files when creating output files\n\n" +
                "\tOutput files have names formatted as " +
                    "\"output-file-prefix\" + the 0-padded index of the file, " +
                    "where the number of 0's is determined by the number of " +
                    "decimal digits necessary to represent n")
        sys.exit(1)
    
    num_files = int(sys.argv[1])

    num_digits = int(numpy.ceil(numpy.log10(num_files)))

    # File existence errors
    if not os.path.exists(sys.argv[2]):
        print("Input file " + sys.argv[2] + " could not be found.")
        sys.exit(2)

    if len(sys.argv) < 5 or sys.argv[4] != "-f":
        names_to_check = [sys.argv[3] + str(i).zfill(num_digits) for i in range(num_files)]

        for filename in names_to_check:
            if os.path.exists(filename):
                print("Output file " + filename + " already exists. Please " +
                        "use another filename prefix or use the -f (force) option")

    output_lines = [[] for i in range(num_files)]

    rng = numpy.random.default_rng()

    # Python's "wrapped" try-catch block equivalent statement/
    # error handler
    with open(sys.argv[2], encoding = "utf-8") as input_file:
        line = input_file.readline()

        while line: # While line is not empty, i.e. there are lines to be read
            dest_file_index = rng.integers(low=0,high=5,size=1)[0]

            output_lines[dest_file_index].append(line)

            line = input_file.readline()

    input_file.close()

    for i in range(num_files):
        output_filename = sys.argv[3] + str(i).zfill(num_digits)

        with open(output_filename, 'w') as output_file:
            for j in range(len(output_lines[i])):
                output_file.write(output_lines[i][j])

        output_file.close()

# End main()


if __name__ == "__main__":
    main()
