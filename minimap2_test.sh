


# Run minimap for multiple alignments. Test with nanopore and illumina reads

# Check that we get the expected number of kmers

# Read the output sam file

# Get the same file sequences into a fasta file with the following in each of the headers
	# 1) the read name
	# 2) the read position from minimap2 (in the sam file)
	# 3)it's sequences
	# 	There may be split alignments 

# Make meryl database from the reference genome

# Make meryl database with the reads

# make a histogram with the number of intersecting unique kmers 

# Get all the reads that were not aligned by minimap
# Run the other basic meryl script to see if there are intersecting uqniue kmers 