#!/bin/bash
#SBATCH --job-name=syri_plot
#SBATCH -A co_moilab
#SBATCH -p savio3
#SBATCH -N 1
#SBATCH --qos=savio_lowprio
#SBATCH --requeue
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/plot%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/structural_variation/syri_logs/plot%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate plotsr_dep_env

cd ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri

sh ${path_to_working}/magic_thesis/scripts/bash_scripts/structural_variation/plotsr/plotsr_command.sh | /bin/bash
