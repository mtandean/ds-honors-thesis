#!/bin/bash
#SBATCH --job-name=repeat_masker
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 15
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeatmasker_logs/repeatmasker%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeatmasker_logs/repeatmasker%A_%a.out

cd ${SLURM_SUBMIT_DIR}
name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/annotation/repeatmasker/command_txt/repeatmasker_commands.txt | /bin/bash
