# set general variables
path_to_working={YOUR_PATH_HERE} # where you want the directories to be created
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked

sample_name=m84268_250919_003033_s1.hifi_reads.22571_XW # name of specific sample (or use a loop to do all samples)
sample_alias=22571 # shorthand for sample

num_threads=5 # number of threads to use for processes, can change wherever


# required: braker2 (in this code, in apptainer image), liftoff (in this code, conda env liftoff_env), genespace (dependencies in conda env genespace_env), R (in this code, from module)


###########################################################
###########################################################


# run BRAKER2 with protein orthodb from Viridiplantae and TAIR12 annotation, with existing Arabidopsis species setting for Augustus

mkdir -p ${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker

cd ${path_to_working}/magic_thesis/external_data/external_annotations/

cd braker_ortho_db

# add Arabidopsis protein file to get proteins for BRAKER2 input
cat GCA_978657495.1_TAIR12_protein.faa Viridiplantae_renamed.fa > braker_proteins.fa

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker

output_dir=${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker
protein_loc=${path_to_working}/magic_thesis/external_data/external_annotations/braker_ortho_db/braker_proteins.fa

masked_genome_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker/${i}.asm.bp.p_ctg.scaffold.fa.masked


apptainer exec  ${path_to_working}/apptainer_dir/braker3.sif braker.pl --genome=$masked_genome_loc --prot_seq=$protein_loc --workingdir=$output_dir --AUGUSTUS_CONFIG_PATH=${path_to_working}/apptainer_dir/Augustus/config --GENEMARK_PATH=~/bin/GeneMark-ETP/bin/gmes --threads=$num_threads --useexisting --species arabidopsis


# run LiftOff with TAIR12 annotations
mkdir -p ${path_to_working}/magic_thesis/intermediate_data/annotation/liftoff/${num}_liftoff

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/liftoff

genome_loc=${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${sample_name}.asm.bp.p_ctg.scaffold.fa
       
gff_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_genomic.gff

ref_loc=${path_to_working}/magic_thesis/external_data/external_assemblies/raw/GCA_978657495.1_TAIR12_genomic.fna

liftoff $genome_loc $ref_loc -o ${num}_liftoff -g $gff_loc -p $num_threads

# make peptide fasta and bed file from braker annotations
braker_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker

# get only the genes from the annotations for bed
awk -v OFS='\t' '$3 == "gene" {print $1, $4, $5, $9}' $braker_loc/braker.gtf > ${path_to_working}/magic_thesis/intermediate_data/annotation/genespace/bed/${num}.bed

# get amino acid sequence of fasta
awk '/^>/ {if ($1 ~ /\.t1$/) {sub(/\.t1$/, ""); print; keep=1} else {keep=0}; next} keep {print}' $braker_loc/braker.aa > ${path_to_working}/magic_thesis/intermediate_data/annotation/genespace/peptide/${num}.fa

# run genespace R script
module load r
R CMD BATCH --no-save 
${path_to_working}/magic_thesis/scripts/R_scripts/genespace.R ${path_to_working}/magic_thesis/log_slurm/annotation/genespace_logs/genespace.Rout


