for j in {1..8}
do
	i=$(sed -n "${j}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
	tmp="${i##*reads.}"
        num="${tmp%%_*}"

sed "s/^>/>${num}#${j}#/" ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contigs/clean_${i}.asm.bp.p_ctg.fa > ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb_filter/pggb_prep_assemblies/filter_${i}.asm.bp.p_ctg.renamed.fa

done

cp  ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb/pggb_prep_assemblies/TAIR12.renamed.fa ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb_filter/pggb_prep_assemblies/TAIR12.renamed.fa


cd ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb/pggb_prep_assemblies

module load bio/samtools
cat *renamed.fa > ../../pggb_filtered/pggb_in_filter.fa
samtools faidx ../../pggb_filtered/pggb_in_filter.fa

