#!/bin/bash
#SBATCH --job-name=pan_edta
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=1
#SBATCH -N 1
#SBATCH -c 20
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/pan_edta%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/edta_logs/pan_edta%A_%a.out

source ~/miniforge3/etc/profile.d/mamba.sh
mamba activate edta_env
cd ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta
curatedlib_loc="${path_to_working}/magic_thesis/external_data/external_annotations/athrep.updated.fasta_073025"
cds_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_cds_from_genomic.fna
sh panEDTA.sh -g pan_edta_genome_list.txt -c $cds_loc -l $curatedlib_loc -t 19 -o 1

