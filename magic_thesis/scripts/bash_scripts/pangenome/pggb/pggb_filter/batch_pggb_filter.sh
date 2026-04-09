#!/bin/bash
#SBATCH --job-name=pggb_filter
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH -N 1
#SBATCH -c 31
#SBATCH --time=2-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/pggb_logs/pggb_filter%A.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/pggb_logs/pggb_filter%A.out

cd ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb_filter

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate pggb_env

pggb -i pggb_in_filter.fa -n 9 -t 30 -p 95  -s 50000 -V "TAIR12" -m -o pggb_filter_output

