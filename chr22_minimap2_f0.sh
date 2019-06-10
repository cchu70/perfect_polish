#!/bin/bash

# 20 threads = 20 CPUs


module load minimap2
module load samtools

f_val=$1
input_path=/data/rhiea/chr22-sim/

echo $f_val

echo "minimap2 -x map-ont -N50 -r30000 -a -t${SLURM_CPUS_PER_TASK}  -f${f_val} ${input_path}chr22.fasta ${input_path}chr22-a02-s10.fasta | samtools view -hb -@4 > minimap2_N50_r30kb_${f_val}.bam"
minimap2 -x map-ont -N50 -r30000 -a -t${SLURM_CPUS_PER_TASK}  -f${f_val} ${input_path}chr22.fasta ${input_path}chr22-a02-s10.fasta | samtools view -hb -@4 > minimap2_N50_r30kb_${f_val}.bam
samtools sort -@$SLURM_CPUS_PER_TASK -O cram --reference=${input_path}chr22.fasta -T minimap2_N50_r30kb_${f_val}.tmp minimap2_N50_r30kb_${f_val}.bam > minimap2_N50_r30kb_${f_val}.cram
samtools index minimap2_N50_r30kb_${f_val}.cram
/home/rhiea/tools/IGVTools/igvtools count minimap2_N50_r30kb_${f_val}.cram minimap2_N50_r30kb_${f_val}.tdf ${input_path}chr22.fasta.fai