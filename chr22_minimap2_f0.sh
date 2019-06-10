#!/bin/bash

# 20 threads = 20 CPUs


module load minimap2
module load samtools

f_val=0.0002

minimap2 -x map-ont -N50 -r30000 -a -t20  -f$f_val /data/rhiea/chr22-sim/chr22.fasta /data/rhiea/chr22-sim/chr22-a02-s10.fasta | samtools view -hb -@4 > minimap2_N50_r30kb.bam
samtools sort -@20 -O cram --reference=chr22.fasta -T minimap2_N50_30kb.tmp minimap2_N50_30kb.bam > minimap2_N50_r30kb.cram
samtools index minimap2_N50_30rkb.cram
/home/rhiea/tools/IGVTools/igvtools count minimap2_N50_30kb.cram minimap2_N50_30kb.tdf chr22.fasta.fai