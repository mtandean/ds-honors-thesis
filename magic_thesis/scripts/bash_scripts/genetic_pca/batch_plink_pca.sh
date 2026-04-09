#!/bin/bash
#SBATCH --job-name=plink_pca
#SBATCH -A co_moilab
#SBATCH -p savio2
#SBATCH --array=1
#SBATCH -N 1
#SBATCH --qos=savio_lowprio
#SBATCH --requeue
#SBATCH --time=1-00:00:00
#SBATCH --error=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/genetic_pca/plink_pca_logs/pca%A_%a.err
#SBATCH --output=/global/home/users/mtandean/scratch/magic_thesis/log_slurm/genetic_pca/plink_pca_logs/pca%A_%a.out

VCF=$path_to_working/magic_thesis/external_data/external_vcf/1001g_regmap_mac10.recode.vcf


plink --vcf $VCF --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $path_to_working/magic_thesis/intermediate_data/genetic_pca/1001g_regmap_mac10.prune.in --threads 23 --make-bed --pca --out $path_to_working/magic_thesis/intermediate_data/genetic_pca/1001g_regmap_mac10_pca
