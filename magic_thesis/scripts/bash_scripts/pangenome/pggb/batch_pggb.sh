#!/bin/bash
#SBATCH --job-name=pggb_98
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1
#SBATCH -N 1
#SBATCH -c 31
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/pggb_logs/pggb_95%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/pggb_logs/pggb_95%A_%a.out

cd ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb
source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate pggb_env

pggb -i pggb_input.fa -n 9 -t 30 -p 98  -s 10000 -V "Col-CC" -o pggb_98_output -m

