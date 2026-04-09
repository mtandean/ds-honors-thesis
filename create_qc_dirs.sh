cd ${path_to_working}
mkdir quality_check
cd quality_check
mkdir data results scripts log_slurm

cd scripts
mkdir setup

cd setup
echo "arabidopsis_pangenome" >> sources.txt
echo "magic_arabidopsis_genome" >> sources.txt
echo "apg" >> aliases.txt
echo "mg" >> aliases.txt

#create lists of each part
printf "%s\n" assembly_data intermediate_data read_data > data_parts.txt

cd ../../data

for i in `cat ${path_to_working}/quality_check/scripts/setup/sources.txt`
do
        mkdir $i
        cd $i
        for j in `cat  ${path_to_working}/quality_check/scripts/setup/data_parts.txt`
        do
                mkdir $j
        done
	cd intermediate_data
	mkdir meryl_read_dbs aligned_reads
	mkdir aligned_reads/preset
        cd ../..
done

mkdir arabidopsis_pangenome/read_data/illumina

cd ../results
mkdir flagstat_results inspector_results merqury_results
for i in `ls`
do
        cd $i
        for j in `cat ${path_to_working}/quality_check/scripts/setup/aliases.txt`
        do
                mkdir $j
        done
        cd ..
done
mkdir tables

cd ../log_slurm
mkdir inspector_logs  merqury_logs  mm2_samtools_logs  nucflag_logs  setup_logs
for i in `ls`
do
        mkdir $i/apg $i/mg
done

cd ../scripts
mkdir inspector merqury mm2_samtools tables


for i in `ls -d */`
do
        mkdir ${i}command_txt ${i}make_commands

done

