for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
num="${tmp%%_*}"
echo "busco -c 2 -i ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -m genome -l ${path_to_working}/magic_thesis/external_data/external_lineages/brassicales_odb12 --out_path ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_filter_test/busco_brassicales/ -o ${num}_busco"

done

