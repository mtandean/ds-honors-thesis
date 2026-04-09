#!/bin/bash
#SBATCH --job-name=syri_ref
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH --array=1
#SBATCH -N 1
#SBATCH 
#SBATCH --qos=savio_lowprio
#SBATCH --requeue
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/syri_ref%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/syri_ref%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate minimap2_env

cd ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri

ref_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/TAIR10_renamed.fa
qry_name=$(sed -n "1p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies

ref_num="TAIR10"
tmp="${qry_name##*reads.}"
qry_num="Col-PEK"
prefix="${ref_num}-${qry_num}"
mkdir ${prefix}_syri

minimap2 -t 31 -ax asm5 --eqx  ${fasta_loc}/${ref_num}_renamed.fa ${fasta_loc}/${qry_num}_renamed.fa  > sam/${prefix}.sam

mamba activate syri_env
syri -c sam/${prefix}.sam -r ${fasta_loc}/${ref_num}_renamed.fa  -q ${fasta_loc}/${qry_num}_renamed.fa -k -F S --dir ${prefix}_syri --prefix "${prefix}_"  --nc 31


mamba activate minimap2_env


ref_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/Col-PEK_renamed.fa
qry_name=$(sed -n "1p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies

ref_num="Col-PEK"
tmp="${qry_name##*reads.}"
qry_num="${tmp%%_*}"
prefix="${ref_num}-${qry_num}"
mkdir ${prefix}_syri

minimap2 -t 31 -ax asm5 --eqx ${ref_loc} ${fasta_loc}/${qry_num}_renamed.fa  > sam/${prefix}.sam

mamba activate syri_env
syri -c sam/${prefix}.sam -r ${ref_loc} -q ${fasta_loc}/${qry_num}_renamed.fa -k -F S --dir ${prefix}_syri --prefix "${prefix}_"  --nc 31

mamba activate minimap2_env
ref_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/TAIR12_renamed.fa
qry_name=$(sed -n "8p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies

qry_num="TAIR12"
tmp="${qry_name##*reads.}"
ref_num="${tmp%%_*}"
prefix="${ref_num}-${qry_num}"
mkdir ${prefix}_syri

minimap2 -t 31 -ax asm5 --eqx  ${fasta_loc}/${ref_num}_renamed.fa ${fasta_loc}/${qry_num}_renamed.fa  > sam/${prefix}.sam

mamba activate syri_env
syri -c sam/${prefix}.sam -r ${fasta_loc}/${ref_num}_renamed.fa -q ${fasta_loc}/${qry_num}_renamed.fa -k -F S --dir ${prefix}_syri --prefix "${prefix}_"  --nc 31



