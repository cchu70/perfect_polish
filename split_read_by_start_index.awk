# Split fasta file with headers including the start and end indices in the header
# Compare the actual index with the aligned region (index also in the header)

# TODO: changing the delimiter to be only "_", so set this in the awk script
# Note that the bed file is tab delimited. 



BEGIN {
	
	t_file="test.sec_reads.true.fasta"; # Input file names
	f_file="test.sec_reads.false.fasta";
	print_to_file=f_file;
	keys["test"]="test";
	ids["test"]="test";
}

{
if (FNR == NR) {
	keys[$4]=$2; 
	next;
}
else
{
	if (/^>/) {

		# is the header, want to parse it
		part_num=$2;
		read_start_idx = $3;
		read_end_idx = $4;

		# Get the index from the mapping
		algn_read_idx = $7;
	
		# Get the index of the part from the original assembly
		part_start = keys[part_num];
		true_start_idx = part_start + read_start_idx;
		true_end_idx = part_start + read_end_idx;

		if (true_idx <= algn_read_idx && algn_read_idx < true_end_idx) {
			# Correct alignment
			print "Correct!"
			print_to_file = t_file;
		} else {
			# Incorrect alignment
			print_to_file = f_file;
			print "True_idx: "true_idx" Mapped: "algn_read_idx;
		}

		print $0 >> print_to_file;
	} else {
		# it is a sequence, just print
		print $0 >> print_to_file;
	}
}
}
