#!/bin/bash
#SBATCH --job-name=liftoff
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/liftoff_logs/liftoff%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/liftoff_logs/liftoff%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate liftoff_env


name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/liftoff/${num}_liftoff

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/annotation/liftoff/command_txt/liftoff_commands.txt | /bin/bash
