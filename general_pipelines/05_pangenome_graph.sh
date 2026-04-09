# set general variables
path_to_working={YOUR_PATH_HERE} # where you want the directories to be created
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked
num_threads=30 # number of threads to use for processes, can change wherever


# required: seqkit (in this code, in bin), minigraph cactus (in this code, in apptainer image), pggb (in this code, in conda env pggb_env)


###########################################################
###########################################################
mkdir -p ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes


# rename MAGIC genomes according to panSN-spec naming rules
for i in  `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
tmp="${i##*reads.}"
        num="${tmp%%_*}"
seqkit replace -p "^" -r "${num}#1#" ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/${num}_panSN_spec.fa
done


# rename reference genomes TAIR12 and Col-PEK according to panSN-spec naming rules

seqkit replace -p "^" -r "TAIR12#1#" ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR12_renamed.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/TAIR12_panSN_spec.fa


seqkit replace -p "^" -r "Col-PEK#1#" ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/Col-PEK_panSN_spec.fa

mkdir -p ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus

for i in `ls ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/*`
do
        tmp=${i##*genomes/}
        name=${tmp%%_pan*}
        echo -e "${name}\t$i" >> ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus/cactus_list.seqfile
done

# run minigraph cactus 
apptainer exec ${path_to_working}/apptainer_dir/cactus_v3.1.4.sif cactus-pangenome ./js_cactus ./cactus_list.seqfile --mgCores $num_threads \
  --outDir ./cactus_output \
  --outName magic_cactus_pangenome \
  --reference Col-PEK \
  --permissiveContigFilter 0.1 \
  --gfa clip filter \
  --gbz clip filter \
  --giraffe clip filter \
  --odgi \
  --vcf \
  --logFile mg_cactus.log \
  --snarlStats clip filter full \
  --mgSplit
