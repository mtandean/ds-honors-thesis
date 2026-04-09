#!/bin/bash
#SBATCH --job-name=genespace
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH --array=1
#SBATCH -N 1
#SBATCH

#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/genespace_logs/genespace%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/genespace_logs/genespace%A_%a.out

module load r
#source ~/miniforge3/etc/profile.d/mamba.sh
#mamba activate genespace_env2

cd ${path_to_working}/magic_thesis/intermediate_data/annotation/genespace
export PATH="/global/home/users/mtandean/miniforge3/envs/genespace_env2/bin:$PATH"
xvfb-run -a R CMD BATCH --no-save ${path_to_working}/magic_thesis/scripts/R_scripts/genespace.R ${path_to_working}/magic_thesis/log_slurm/annotation/genespace_logs/genespace.Rout
#Rscript ${path_to_working}/magic_thesis/scripts/R_scripts/genespace.R
