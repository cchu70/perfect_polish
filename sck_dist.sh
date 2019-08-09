#!/bin/bash

# This script produces the kmer histogram of the intersection between the single copy kmers in the reference genome
# to the kmer counts in the raw reads to gauge the distribution of unique kmers throughout the genome

# Values
ref_unique_db=$1 # i.e. chr22_asm_1.meryl
# k_size=$2
# run_name=$3 	# Ideally the same heading as the read fasta file
run_name=$2
read_fa=$run_name.fasta		

module load canu

# # Make the read database

# meryl count k=$k_size $read_fa output $run_name.meryl

# # Intersect
# meryl intersect $read_db $ref_unique_db output $run_name.intersect.meryl

# # Make histogram: jellyfish format for genomescope to view
# meryl histogram $run_name.meryl | awk '{print $1" "$2}' > $run_name.histo 

# To normalize the kmercounts by the lengths of the reads, need to change
# the kmer counts for each read by the length of the read

# Count how many kmers from the unique database is on each read
meryl-lookup -existence -mers $ref_unique_db -sequence $read_fa -threads 8 -memory 12 > $run_name.lookup_exist.txt

# Normalize the kmer count per read by the length of the read
	# The length of a read is the #kmers + k-1 
	# Scale to get whole numbers we can round
scale=1000
cat $run_name.lookup_exist.txt | awk '{printf "%3.0f\n", $scale*$NF/($2 + 20)}' > $run_name.norm.txt

# Create a frequency histogram
java -jar -Xmx1G /home/rhiea/codes/txtColumnSummary.jar 1 $run_name.norm.txt | awk '{print $1" "$2}' > $run_name.kcount_per_read.histo

# Rscript?