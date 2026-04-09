cd ${path_to_working}
mkdir magic_thesis
cd magic_thesis
mkdir external_data intermediate_data results log_slurm meta_info raw_data scripts

#create lists of each part
printf "%s\n" annotation assembly genetic_pca pangenome structural_variation evaluation_assembly > meta_info/main_parts.txt
#printf "%s\n" braker edta genespace liftoff pan_edta repeatmasker > meta_info/annotation_parts.txt (not necessary)
#printf "%s\n" busco_filter  organelle_filter  ragtag > meta_info/assembly_parts.txt  (not necessary)


cd external_data
mkdir climate_data external_annotations external_assemblies external_lineages external_vcf

cd external_annotations
mkdir braker_ortho_db

cd ../../intermediate_data
for i in `cat ../meta_info/main_parts.txt`
do
	mkdir $i
done

cd annotation
mkdir braker edta genespace liftoff pan_edta softmasked_genomes

cd genespace
mkdir bed peptide

cd ../../assembly
mkdir busco_filter_test busco_organelle_test filtered_contig_assemblies flagged_contigs  organelle_filter scaffolded_assemblies contig_assemblies hifiasm_assembly ragtag

cd ../evaluation_assembly
mkdir aligned_reads  jellyfish_dbs  meryl_read_dbs

cd ../pangenome
mkdir panSN_spec_genomes minigraph_cactus pggb

cd ../genetic_pca
mkdir plink snprelate

cd ../structural_variation
mkdir syri

cd syri
mkdir renamed_assemblies sam

cd ../../../log_slurm
for i in `cat ../meta_info/main_parts.txt`
do
	mkdir $i
done

cd annotation
mkdir braker_logs  edta_logs  genespace_logs liftoff_logs  repeatmasker_logs 

cd ../assembly
mkdir busco_filter_logs  organelle_filter_logs ragtag_log hifiasm_logs 

cd ../genetic_pca
mkdir plink_pca_logs

cd ../pangenome
mkdir cactus_logs  pggb_logs

cd ..
mkdir structural_variation/syri_logs

cd ../results
mkdir figures tables


#commented out in setup
cd ../scripts
mkdir bash_scripts R_scripts
cd bash_scripts

for i in `cat ../../meta_info/main_parts.txt`
do
	mkdir $i
done

cd annotation
mkdir braker edta genespace liftoff pan_edta repeatmasker
for i in `ls`
do
	mkdir $i/command_txt $i/make_commands
done

cd ../assembly
mkdir busco_filter  organelle_filter  ragtag
for i in `ls`
do
	mkdir $i/command_txt $i/make_commands
done

cd ../evaluation_assembly
mkdir fastqc merqury inspector jellyfish minimap2 quast assmebly_stats
for i in `ls`
do
	mkdir $i/command_txt $i/make_commands
done

cd ../pangenome
mkdir pggb minigraph_cactus
for i in `ls`
do
	mkdir $i/command_txt $i/make_commands
done

cd ../structural_variation
mkdir syri plotsr
for i in `ls`
do
	mkdir $i/command_txt $i/make_commands
done

