# set general variables
path_to_working={YOUR_PATH_HERE} # where the project directory is located

# required: seqkit (in bin)

###########################################################
###########################################################

cd ${path_to_working}/magic_thesis/external_data/external_assemblies

# relabel chromosomes of TAIR12 as "Chr#"
sed 's/^>.*\([12345]\)/>Chr\1/g' raw/GCA_978657495.1_TAIR12_genomic.fna > TAIR12_renamed.fa

# relabel chromosomes of Col-PEK as "Chr#"
sed 's/^>.*chromosome \([12345]\)/>Chr\1/g' raw/GCA_020911765.2_ASM2091176v2_genomic.fna > Col-PEK_renamed.fna

# relabel nuclear chromosomes of TAIR10 as "Chr#", chloroplast as "Pt", mitochondrion as "Mt"
sed 's/^>\([PM]t\).*/>\1/g' raw/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa > TAIR10_renamed.fa
sed -i 's/^>.*Chromosome \([12345]\)/>Chr\1/g' TAIR10_renamed.fa

# extract nuclear chromosomes from TAIR10
seqkit grep -r -p ".*[12345]" ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR10_renamed.fa -o ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR10_filtered.renamed.fa


# extract chloroplast and mitochondrion reference from TAIR10 and to get organelle references
seqkit grep -r -p "[MP]t" TAIR10_renamed.fa -o organelles_renamed.fa

# strip whitespace from headers in Viridiplantae fasta file 
sed '/^>/s/[[:blank:]]/_/g' Viridiplantae.fa > Viridiplantae_renamed.fa
