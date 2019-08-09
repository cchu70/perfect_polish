# Splitting input1 fasta based on if the ID is found in intpu2 fasta file
# Motivated by seeing if some of the false primary reads have corresponding true secondary reads


BEGIN {
	# Delimit by ";"
	FS=";"
	t_file="prim_false.sec_true.fasta";
	f_file="prim_false.sec_false.fasta";
	print_to_file=f_file;
}

{
if (FNR == NR) {
	# First file is just a list of read names (only) in the sec_true file;
	keys[$1] = "True";
}
else
{
	# Looking at the file with all the false primary reads
	if (/^>/) {

		# Looking at header
		name=$1
		if (keys[name]) {
			print_to_file=t_file;
		} else {
			print_to_file=f_file;
		}

		print $0 >> print_to_file;
	} else {
		# it is a sequence, just print
		print $0 >> print_to_file;
	}
}
}
