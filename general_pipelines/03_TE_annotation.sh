# set general variables
path_to_working={YOUR_PATH_HERE} # location of the project directory
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked

sample_name=m84268_250919_003033_s1.hifi_reads.22571_XW # name of specific sample (or use a loop to do all samples)
sample_alias=22571 # shorthand for sample

num_threads=5 # number of threads to use for processes, can change wherever


# required: edta (in this code, in conda env edta_env), masker (in this code, an apptainer image TETools)


###########################################################
###########################################################

mkdir -p ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta

conda activate edta_env
# run EDTA with TAIR12 TE and CDS annotations
curatedlib_loc="${path_to_working}/magic_thesis/external_data/external_annotations/athrep.updated.fasta_073025"

cds_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_cds_from_genomic.fna

perl ~/bin/EDTA/EDTA.pl --genome ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${sample_name}.asm.bp.p_ctg.scaffold.fa --curatedlib $curatedlib_loc --cds $cds_loc --anno 1 --threads $num_threads --evaluate 1 --u 7.0e-9

# create list of genomes
for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
 echo ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/${i}.asm.bp.p_ctg.fa >> ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/pan_edta_genome_list.txt
done

# run panEDTA to create panTE library
cd ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta

sh panEDTA.sh -g pan_edta_genome_list.txt -c $cds_loc -l $curatedlib_loc -t $num_threads -a 0


# use panTE library to annotate and softmask genomes with RepeatMasker
mkdir -p ${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker

output_dir=${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker

panTElib_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/TAIR10/edta/pan_edta/pan_edta_genome_list.txt.panEDTA.TElib.fa

genome_dir=${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i.asm.bp.p_ctg.ragtag.scaffold.fa
apptainer exec  ${path_to_working}/apptainer_dir/tetools_latest.sif RepeatMasker -pa 14 -lib $panTElib_loc -xsmall -dir $output_dir $genome_dir


# evaluate annotation of genomes with panTE library with EDTA

perl ~/bin/EDTA/EDTA.pl --genome ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${sample_name}.asm.bp.p_ctg.scaffold.fa --curatedlib $curatedlib_loc --cds $cds_loc --rmout $output_dir/rm.out --anno 1 --threads $num_threads --evaluate 1 --u 7.0e-9

