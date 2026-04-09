#!/bin/bash
#SBATCH --job-name=panedta_eval
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 20
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/edta_eval/pan_eval%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/edta_eval/pan_eval%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate edta_env

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/annotation/pan_edta/command_txt/pan_edta_eval_commands.txt | /bin/bash

