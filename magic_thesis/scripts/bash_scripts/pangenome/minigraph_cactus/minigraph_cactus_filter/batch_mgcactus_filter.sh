#!/bin/bash
#SBATCH --job-name=cactus_filter
#SBATCH --partition=savio3
#SBATCH -N 1
#SBATCH --time=3-00:00:00
#SBATCH -A co_moilab
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mtandean@berkeley.edu 
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/cactus_logs/mgcactus_filter%A.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/pangenome/cactus_logs/mgcactus_filter%A.out

cd ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus_filter


rm -rf ./js_cactus

apptainer exec ${path_to_working}/apptainer_dir/cactus_v3.1.4.sif cactus-pangenome ./js_cactus ./cactus_list.seqfile --mgCores 30 \
  --outDir ./cactus_output \
  --outName magic_cactus_pangenome \
  --reference TAIR12 \
  --permissiveContigFilter 0.1 \
  --gfa clip filter \
  --gbz clip filter \
  --giraffe clip filter \
  --odgi \
  --vcf \
  --logFile mg_cactus.log \
  --snarlStats clip filter full \
  --mgSplit

