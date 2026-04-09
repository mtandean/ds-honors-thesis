#!/bin/bash
#SBATCH --job-name=repeat_modeler
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 15
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeat_modeler_logs/repeat_modeler%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeat_modeler_logs/repeat_modeler%A_%a.out

start_line=$(( 1+(2*(${SLURM_ARRAY_TASK_ID}-1)) ))
next_line=$(( 1+${start_line} ))
name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working_mt}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"
cd ${path_to_working_mt}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler

sed -n "${start_line},${next_line}p" ${path_to_working_mt}/magic_thesis/scripts/bash_scripts/annotation/repeat_modeler/command_txt/repeat_modeler_commands.txt | /bin/bash

