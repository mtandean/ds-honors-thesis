#!/bin/bash
#SBATCH --job-name=ragtag_scaff
#SBATCH -A co_moilab
#SBATCH -p savio2_htc
#SBATCH --array=1-8
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/ragtag_logs/ragtag%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/assembly/ragtag_logs/ragtag%A_%a.out

cd $SLURM_SUBMIT_DIR
source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate ragtag_env
sed -n "${SLURM_ARRAY_TASK_ID}p" command_txt/ragtag_commands.txt | /bin/bash

