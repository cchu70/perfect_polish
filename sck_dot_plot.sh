#!/bin/bash

# This script is intended to produce a dot plot denoting the unique kmers found in a read and where it is found in the 
# original assembly


# Input
ref_fa=$1
reads_fa=$2
unique_pos_db=$3 # meryl db
parts_bed=$4
name=$5 # output file names

# Modules
module load canu

# Get the coordinates of the kmers in the ref

# Wait I already made a meryl database for the unique kmers and their locations (can just do meryl print to get the kmer and it's value)
# The value is usually the count, but we made it so that it would store the kmer position

#To make unique kmer position 




# Get the kmers in the reads need to awk now otherwise the file gets really really big
meryl-lookup -dump -sequence chr22-a02-s10.reads.fasta -mers chr22_unique_pos.meryl -threads 8 -memory 20g -min 1 | awk '$3=="T" {print $1"\t"$2"\t"$5}' > tmp.k_coor.txt

# The file will be in the form of 
# read_name, pos of kmer in the sequence, T/F, forward mer, value (position) of forward mer, and backwards mer stuff

cat $name.k_read_pos.dump.txt | awk -F '\t' '$3="T" && $4 > 0 {print $1, $2, $5}' > tmp.${name}.k_coor.txt

# Got the read name, the position of the kmer in the sequence, and the position of the kmer in the ref
# Calculate the position of the kmer in the read if the read was placed correctly

# cal_k_coor.awk parses out the true coordinates
awk -f cal_k_coor.awk $parts_bed ttmp.${name}.k_coor.txt > ${name}.k_coor.txt
# Basically add the read position to the kmer position in that read (x), and y is the placement in the ref 

# Plot in R
Rscript k_coor.dot_plot.R $name ${name}.k_coor.txt 10 10


# consider a different script that can reduce the size of the file by putting all the points that share an x coordinate together?


