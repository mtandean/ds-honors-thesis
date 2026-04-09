#!/bin/bash
#SBATCH --job-name=fastq_qc
#SBATCH -A co_moilab
#SBATCH -p savio4_htc
#SBATCH --array=1-12
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --mem=48g
#SBATCH --time=7-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/raw_sequencing_data/hifi_reads/log/fastq%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/raw_sequencing_data/hifi_reads/log/fastq%A_%a.out
# run the command


cd $SLURM_SUBMIT_DIR


#module load VCFtools


source ~/miniforge3/etc/profile.d/conda.sh


conda activate fastqc


sed -n "${SLURM_ARRAY_TASK_ID}p" qc_commands.txt | /bin/bash
