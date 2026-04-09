#!/bin/bash

# --- Variables ---
GENOME="$1"
REPEAT="pAL1_repeat.fa"
tmp=${GENOME##*assemblies/}
PREFIX=${tmp%%_renamed*} # The accession ID
WINDOW_SIZE=100000 # 100kb windows

echo "Step 1: Mapping the 178-bp repeat to the genome using minimap2..."
# KEY PARAMETERS FOR TANDEM REPEATS:
# -c      : Output alignments in PAF format (much easier to parse than SAM).
# -N 10000: Retain up to 10,000 secondary alignments (crucial for centromeres).
# -f 10000: Disable the filter that ignores highly repetitive k-mers (without this, minimap2 is blind to centromeres).
# -p 0.5  : Lower the secondary alignment score ratio to catch slightly mutated/diverged repeat copies.
minimap2 -c -N 10000 -f 10000 -p 0.5 $GENOME $REPEAT > ${PREFIX}_repeats.paf

echo "Step 2: Converting PAF output to BED format..."
# In PAF format, Column 6 is Target(Chromosome), Col 8 is Start, Col 9 is End
awk 'BEGIN {OFS="\t"} {print $6, $8, $9}' ${PREFIX}_repeats.paf | sort -k1,1 -k2,2n > ${PREFIX}_repeats.bed

echo "Step 3: Generating chromosome sizes and sliding windows..."
# Get chromosome lengths using samtools
samtools faidx $GENOME
cut -f1,2 ${GENOME}.fai > ${PREFIX}.genome

# Create 100kb windows across the genome
bedtools makewindows -g ${PREFIX}.genome -w $WINDOW_SIZE > ${PREFIX}_windows.bed

echo "Step 4: Calculating repeat density per window..."
# Count how many repeat hits fall into each 100kb window
bedtools coverage -a ${PREFIX}_windows.bed -b ${PREFIX}_repeats.bed > ${PREFIX}_centromere_density.bed

echo "Pipeline complete! Check ${PREFIX}_centromere_density.bed

"
