# set general variables
path_to_working={YOUR_PATH_HERE} # where you want the directories to be created
path_to_bin={YOUR_PATH_HERE} # where executables should be installed or linked
num_threads=30 # number of threads to use for processes, can change wherever


# required: minimap2 (in this code, in conda env minimap2_env) syri (in this code, in conda env syri_env), plotsr (in this code, in conda env plotsr_env)

###########################################################
###########################################################

cd ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/

mkdir sam renamed_assemblies


# rename chromosomes to be the same for syri
for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
sed 's/^>.*\([12345]\).*/>Chr\1/g' ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i.asm.bp.p_ctg.scaffold.filtered.fa  > ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/$num_renamed.fa
done

# get only nuclear chromosomes in TAIR10
seqkit grep -r -p ".*[12345].*" ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR10_renamed.fa > renamed_assemblies/TAIR10_renamed.fa

# link Col-PEK to directory

ln -s ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa renamed_assemblies/Col-PEK_renamed.fa

# create genome text file for plotsr input
echo -e "renamed_assemblies/Col-PEK_renamed.fa\tCol-PEK" >> genomes.txt
echo -e "renamed_assemblies/TAIR10_renamed.fa\tTAIR10" >> genomes.txt
for i in `ls renamed_assemblies/[2]*.fa`
do
	tmp=${i##*assemblies/}
  name=${tmp%%_renamed*}
        echo -e "$i\t$name" >> "${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt"
done


for i in {2..10}
do
conda activate minimap2_env
ref_pos=$(( ${i}-1 ))
ref_name=$(awk --F='\t' -v num=$ref_pos 'NR==ref_pos {print $2}' genomes.txt )
qry_name=$(sed -n "${i}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies

tmp="${ref_name##*assemblies/}"
ref_num="${tmp%%_*}"
tmp="${qry_name##*assemblies/}"
qry_num="${tmp%%_*}"
prefix="${ref_num}-${qry_num}"
mkdir ${prefix}_syri

# align whole genomes to each other
minimap2 -t $num_threads -ax asm5 --eqx  ${fasta_loc}/${ref_num}_renamed.fa ${fasta_loc}/${qry_num}_renamed.fa  > sam/${prefix}.sam

# run syri for finding structural variation
conda activate syri_env
syri -c sam/${prefix}.sam -r ${fasta_loc}/${ref_num}_renamed.fa  -q ${fasta_loc}/${qry_num}_renamed.fa -k -F S --dir ${prefix}_syri --prefix "${prefix}_"  --nc $num_threads
done

conda activate plotsr_env
plotsr \
--sr Col-PEK-TAIR10_syri/Col-PEK-TAIR10_syri.out \
--sr TAIR10-22571_syri/TAIR10-22571_syri.out \
--sr 22571-22582_syri/22571-22582_syri.out \
--sr 22582-22633_syri/22582-22633_syri.out \
--sr 22633-22656_syri/22633-22656_syri.out \
--sr 22656-28962_syri/22656-28962_syri.out \
--sr 28962-76455_syri/28962-76455_syri.out \
--sr 76455-76560_syri/76455-76560_syri.out \
--sr 76560-76789_syri/76560-76789_syri.out \
--cfg base.cfg -H 15 -W 20 \
--genomes genomes.txt -o synteny.png
