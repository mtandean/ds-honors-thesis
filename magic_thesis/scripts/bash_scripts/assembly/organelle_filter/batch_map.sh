#!/bin/bash
#SBATCH --job-name=organelle_mm2
#SBATCH --partition=savio3
#SBATCH -N 1
#SBATCH --array=1-8
#SBATCH --time=3-00:00:00
#SBATCH -A co_moilab
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/organelle_filter_logs/mm2%A%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/organelle_filter_logs/mm2%A%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate minimap2_env

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/assembly/organelle_filter/command_txt/map_commands.txt | /bin/bash

