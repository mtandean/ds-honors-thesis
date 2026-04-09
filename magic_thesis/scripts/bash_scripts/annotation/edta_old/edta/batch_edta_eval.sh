#!/bin/bash
#SBATCH --job-name=edta_eval
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --qos=savio_lowprio
#SBATCH --requeue

#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/edta_eval/eval%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/edta_eval/eval%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate edta_env

name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/indv_edta/${num}_edta_individual_backup

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/annotation/edta/command_txt/edta_eval_commands.txt | /bin/bash

