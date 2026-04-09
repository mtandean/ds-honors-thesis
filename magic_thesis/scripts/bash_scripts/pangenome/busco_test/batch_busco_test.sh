#!/bin/bash
#SBATCH --job-name=busco_test
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 5
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/busco_test_logs/busco%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/busco_test_logs/busco%A_%a.out

name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"

cd ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filt_test
source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate busco_env


sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/scripts/bash_scripts/pangenome/busco_test/command_txt/busco_commands.txt | /bin/bash

