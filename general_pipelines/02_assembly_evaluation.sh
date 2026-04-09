# set general variables
path_to_working={YOUR_PATH_HERE} # location of the project directory
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked

sample_name=m84268_250919_003033_s1.hifi_reads.22571_XW # name of specific sample (or use a loop to do all samples)
sample_alias=22571 # shorthand for sample

num_threads=5 # number of threads to use for processes, can change wherever

# required: jellyfish (in this code, in bin), quast (in this code, in conda env quast_env), merqury (in this code, in bin), samtools (in this code, in module), inspector (in this code, in conda env inspector_env)

###########################################################
###########################################################

# run Jellyfish on reads to produce kmer counts needed for GenomeScope
mkdir -p ${path_to_working}/intermediate_data/evaluation_assembly/jellyfish/$sample_alias
cd ${path_to_working}/intermediate_data/evaluation_assembly/jellyfish/$sample_alias



# count 31-mers in reads (-m 31) with 500MB memory (-s 500M)
zcat m84268_250919_003033_s1.hifi_reads.22571_XW.fastq.gz | ${path_to_bin}/jellyfish count -C -m 31 -s 500M -t $num_threads -o reads_22571_jelly.jf /dev/fd/0

# create histograms of 31-mers
${path_to_bin}/jellyfish histo -t $num_threads reads_22751_jelly.jf > reads_22571_jelly.histo

###########################################################


# **not in code** upload .histo files to the GenomeScope 2.0 website and run with k=31 and default parameters (except for 22571, with avgcov=30)


###########################################################

# run quast on contig assembly

mkdir -p ${path_to_working}/intermediate_data/evaluation_assembly/quast/${sample_alias}_quast

cd ${path_to_working}/intermediate_data/evaluation_assembly/quast/

quast -t $num_threads -o ./${sample_alias}_quast -r ../../../fasta_files/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa ../../../assembly/contig_assemblies/$

# run quast on scaffold assembly

mkdir -p  ${path_to_working}/intermediate_data/evaluation_assembly_ragtag /quast/${sample_alias}_quast 
cd ${path_to_working}/intermediate_data/evaluation_assembly_ragtag/quast/${sample_alias}_quast/

quast -t $num_threads -o ./${sample_alias}_quast  -s -r ../../../fasta_files/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa ../../../ragtag_output/ragtag_scaffolded/${num}_scaffolded/ragtag.scaffold.fasta 


# run merqury
mkdir -p  ${path_to_working}/magic_thesis/intermediate_data/evaluation_assembly/quast/${sample_alias}_quast 

fastq_loq=${path_to_working}/magic_thesis/raw_data/hifi_reads/${fastq_name}

# create kmer database with meryl
meryl count k=31 threads=$num_threads 
${fastq_loc} output ${path_to_working}/magic_thesis/intermediate_data/evaluation_assembly/meryl_read_dbs/${num}.meryl

~/bin/merqury/merqury.sh ${num}.meryl $i merqury_$num

# run minimap2

conda activate minimap2_env

mkdir -p ${path_to_working}/magic_thesis/intermediate_data/evaluation_assembly/mm2_results/${sample_alias}_mm2 



# align reads to assemblies
minimap2 -t $num_threads -ax map-hifi $i ../../../raw_sequencing_data/hifi_reads/${fastq_name} > ${num}_rec_reads_rec_asm.sam

# get flagstat results from alignments
module load bio/samtools
samtools flagstat $i > sam_stats/${num}_stats


# run inspector
conda activate inspector_env
inspector.py -c $i -r ${fastq_loc} -o ${num}_inspector/ --datatype hifi


# run BUSCO on filtered and flagged contigs with eudicotyledons_odb12 lineage
conda activate busco_env

busco -c $num_threads -i ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -m genome -l ${path_to_working}/magic_thesis/external_data/external_lineages/eudicotyledons_odb12 --out_path ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filter_test/busco_eudicotyledons -o ${num}_busco

busco -c $num_threads -i ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -m genome -l ${path_to_working}/magic_thesis/external_data/external_lineages/eudicotyledons_odb12 --out_path ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filter_test/busco_eudicotyledons -o ${num}_busco


# run BUSCO on filtered contigs with brassicales_odb12 lineage


busco -c $num_threads -i ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -m genome -l ${path_to_working}/magic_thesis/external_data/external_lineages/brassicales_odb12 --out_path ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filter_test/busco_brassicales -o ${num}_busco
