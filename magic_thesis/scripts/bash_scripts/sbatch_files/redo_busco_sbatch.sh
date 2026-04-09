#!/bin/bash
#SBATCH --job-name=BUSCO_redo
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --array=1-9
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/busco_log/busco_eudicot%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/busco_log/busco_eudicot%A_%a.out
# run the command

cd $SLURM_SUBMIT_DIR
export _JAVA_OPTIONS="-Xmx16g"
#module load VCFtools

source ~/miniforge3/etc/profile.d/conda.sh

conda activate busco_env

sed -n "${SLURM_ARRAY_TASK_ID}p" redo_submission_busco.txt | /bin/bash
