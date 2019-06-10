#!/bin/bash

# This script produces the kmer histogram of the intersection between the single copy kmers in the reference genome
# to the kmer counts in the raw reads to gauge the distribution of unique kmers throughout the genome

# Values
ref_unique_db=$1 # i.e. chr22_asm_1.meryl
read_db=$2 	     # i.e. reads.meryl
run_name=$3


module load canu

# Intersect
meryl intersect $ref_unique_db $read_db output $run_name.meryl

# Make histogram: jellyfish format for genomescope to view
meryl histogram $run_name.meryl | awk '{print $1" "$2"}' > $run_name.histo 

