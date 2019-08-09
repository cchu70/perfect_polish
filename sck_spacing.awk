# Input is a _merged_ bed file with the first column denoting the name of the sequence or genome
# the second column is the start of the position of a unique kmer in the genome (0 based)
# the third columnd is the end of the position of a unique kmer in the genome (1 based)
# I hope the merged bed file is automatically sorted

# Purpose is to calculate the distances between intervals, back end to front end. Then make a histogram of the frequencies of the distances


BEGIN {
	left_end=-1;
	right_front=-1;
}

{
	if (left_end < 0) {
		# At the very beginning
		left_end=NF; # last column
	} else {
		right_front=$(NF - 1); # Second to last column

		# The ends are 0 based and 1 based
		print right_front + 1 - left_end;

		left_end=NF;
	}
}