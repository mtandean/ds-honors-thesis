#!/bin/bash
#SBATCH --job-name=busco_eudicot
#SBATCH -A co_moilab
#SBATCH -p savio2_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 2
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/busco_filter_logs/busco_eudicotyledons/busco%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/busco_filter_logs/busco_eudicotyledons/busco%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate busco_env
cd ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filter_test/

sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/assembly/busco_filter/command_txt/busco_eudicotyledons_filter_commands.txt | /bin/bash
