#!/bin/bash
#SBATCH --job-name=repeat_modeler
#SBATCH -A co_moilab
#SBATCH -p savio3_htc
#SBATCH --array=3
#SBATCH -N 1
#SBATCH -c 16
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeat_modeler_logs/repeat_modeler%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/annotation/repeat_modeler_logs/repeat_modeler%A_%a.out

start_line=$(( 1+(2*(${SLURM_ARRAY_TASK_ID}-1)) ))
next_line=$(( 1+${start_line} ))
name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt )
tmp="${name##*reads.}"
num="${tmp%%_*}"
cd ${path_to_working}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler

#apptainer exec /global/home/users/mtandean/scratch/apptainer_dir/tetools_latest.sif BuildDatabase -name /global/home/users/mtandean/scratch/magic_thesis/intermediate_data/annotation/repeat_modeler/22633_repeat_modeler/22633_db /global/home/users/mtandean/scratch/magic_thesis/intermediate_data/assembly/contig_assemblies/m84268_250919_003033_s1.hifi_reads.22633_XW.asm.bp.p_ctg.fa
apptainer exec  /global/home/users/mtandean/scratch/apptainer_dir/tetools_latest.sif RepeatModeler -database /global/home/users/mtandean/scratch/magic_thesis/intermediate_data/annotation/repeat_modeler/22633_repeat_modeler/22633_db -LTRStruct -threads 15 -recoverDir RM_4155189.WedApr10949192026


