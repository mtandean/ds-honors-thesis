#!/bin/bash
#SBATCH --job-name=quast_calc
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH -N 1

#SBATCH -c 10
#SBATCH --time=1-00:00:00
#SBATCH --array=1-9

#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/hifiasm_assembly/log/quast%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/hifiasm_assembly/log/quast%A_%a.out
# run the command

cd $SLURM_SUBMIT_DIR
#module load VCFtools

source ~/miniforge3/etc/profile.d/conda.sh

conda activate quast_env

sed -n "${SLURM_ARRAY_TASK_ID}p" submission_quast.txt | /bin/bash

:
