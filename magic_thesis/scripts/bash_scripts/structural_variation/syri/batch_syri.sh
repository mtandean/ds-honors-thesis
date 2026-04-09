#!/bin/bash
#SBATCH --job-name=syri_test
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH --array=2-8
#SBATCH -N 1
#SBATCH 
#SBATCH --qos=savio_lowprio
#SBATCH --requeue
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/syri%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/syri%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate minimap2_env

cd ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri

ref_pos=$(( ${SLURM_ARRAY_TASK_ID}-1 ))
ref_name=$(sed -n "${ref_pos}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
qry_name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies

tmp="${ref_name##*reads.}"
ref_num="${tmp%%_*}"
tmp="${qry_name##*reads.}"
qry_num="${tmp%%_*}"
prefix="${ref_num}-${qry_num}"
mkdir ${prefix}_syri

minimap2 -t 31 -ax asm5 --eqx ${fasta_loc}/${ref_num}_renamed.fa ${fasta_loc}/${qry_num}_renamed.fa  > sam/${prefix}.sam

mamba activate syri_env
syri -c sam/${prefix}.sam -r ${fasta_loc}/${ref_num}_renamed.fa -q ${fasta_loc}/${qry_num}_renamed.fa -k -F S --dir ${prefix}_syri --prefix "${prefix}_"  --nc 31

