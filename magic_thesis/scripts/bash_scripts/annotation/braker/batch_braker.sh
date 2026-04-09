#!/bin/bash
#SBATCH --job-name=braker
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH --qos=savio_lowprio
#SBATCH --requeue
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/braker_logs/braker%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/braker_logs/braker%A_%a.out

name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker
rm -r ${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker/*

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/annotation/braker/command_txt/braker_commands.txt | /bin/bash

