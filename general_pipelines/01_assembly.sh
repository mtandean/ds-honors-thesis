# set general variables
path_to_working={YOUR_PATH_HERE} # where you want the directories to be created
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked

sample_name=m84268_250919_003033_s1.hifi_reads.22571_XW # name of specific sample (or use a loop to do all samples)
sample_alias=22571 # shorthand for sample

num_threads=5 # number of threads to use for processes, can change wherever

# required: pbtk (in bin), hifiasm (in conda env), minimap2 (in conda env), seqkit (in bin), RagTag (in conda env)

###########################################################
###########################################################


cd ${path_to_working}
mkdir raw_data/hifi_reads

# if using raw tar.gz from PacBio: extract the .gz file to bam_files/ and convert to fastq in hifi_reads/
mkdir bam_files

mv ${path_to_working}/ ${path_to_working}/magic_thesis/raw_data/
cd ${path_to_working}/magic_thesis/raw_data/

${path_to_bin}/pbtk/bam2fastq -j $num_threads bam_files/${sample_name}.bam -o hifi_reads/${sample_name}

mkdir ${path_to_working}/intermediate_data/assembly
mkdir ${path_to_working}/intermediate_data/assembly/contig_assemblies

# run hifiasm for assembly
conda activate hifiasm_env 
hifiasm -o ${path_to_working}/intermediate_data/assembly/contig_assemblies/m84268_250919_003033_s1.hifi_reads.22571_XW.asm -t $num_threads -l0 ${path_to_working}/raw_data/hifi_reads/m84268_250919_003033_s1.hifi_reads.22571_XW.fastq.gz 


filt_path="${path_to_working}/magic_thesis/intermediate_data/assembly/organelle_filter"
# calculate alignment of contigs to organelle references
conda activate minimap_env
minimap2 -t 31 -x asm5 ${path_to_working}/magic_thesis/external_data/external_assemblies/organelles_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/$i.asm.bp.p_ctg.fa > ${filt_path}/alignments/${num}_organelle_alignments.paf

# calculate alignment length coverage ratio
sh ${path_to_working}/magic_thesis/scripts/bash_scripts/assembly/organelle_filer/get_alcr.sh  ${filt_path}/alignments/${num}_organelle_alignments.paf >  ${filt_path}/alcr_stats/${num}_alcr.tsv

# get names of contigs that have > 0.1 ALCR (organelle-similar)

awk '{ if ($2 > 0.1) print $1 }' ${filt_path}/alcr_stats/${num}_alcr.tsv > ${filt_path}/organelle_contig_names/${num}_organelle_contig_names.txt

# extract nuclear contigs
seqkit grep -v -f ${filt_path}/organelle_contig_names/${num}_organelle_contig_names.txt    ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/${i}.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa

# extract contigs that are flagged as similar to organelles
seqkit grep -f ${filt_path}/organelle_contig_names/${num}_organelle_contig_names.txt    ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/${i}.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/assembly/flagged_contigs/${i}_flagged.asm.bp.p_ctg.fa



# run RagTag for scaffolding with Col-PEK as reference
mkdir assembly/scaffolded_assemblies
mkdir assembly/ragtag
mkdir assembly/ragtag/${sample_alias}_ragtag 

conda activate ragtag_env
ragtag.py  scaffold ${path_to_working}/external_data/external_assemblies/Col-PEK_renamed.fa
${path_to_working}/intermediate_data/assembly/contig_assemblies/m84268_250919_003033_s1.hifi_reads.22571_XW_nuclear.asm.bp.p_ctg.fa -o ${path_to_working}/intermediate_data/assembly/ragtag/${sample_alias}_ragtag 
 -t $num_threads 

cp ${path_to_working}/intermediate_data/assembly/ragtag/${sample_alias}_ragtag/ragtag.scaffold.fasta ${path_to_working}/intermediate_data/assembly/scaffolded_assemblies/${sample_name} 




