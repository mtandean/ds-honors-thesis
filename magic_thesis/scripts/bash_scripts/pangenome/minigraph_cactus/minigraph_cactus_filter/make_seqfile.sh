echo "TAIR12  /global/home/users/mtandean/scratch/magic_thesis/external_data/external_assemblies/GCA_978657495.1_TAIR12_genomic_renamed.fna" > ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus_filter/cactus_list.seqfile
for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	echo "${num}	${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb_filter/pggb_prep_assemblies/filter_${i}.asm.bp.p_ctg.renamed.fa" >> ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus_filter/cactus_list.seqfile
done


