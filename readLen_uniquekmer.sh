#!/bin/bash
# For each read in the output of meryl-lookup -existence, 
# output a tab delimited file with 
# Col1: group name; col2: read length; col3: unique kmers


group=$1
k_size=$2
look_up_output=$3

out_file=$group.readLen_sck.txt


cat $look_up_output | awk -v group=$group -v k_size=$k_size '{ print group"\t"($2 + k_size - 1)"\t"$NF; }' > $out_file