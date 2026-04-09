for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
echo "busco -i ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_scaffolded_assemblies/$i.asm.bp.p_ctg.ragtag.scaffold.filtered.fa -l ${path_to_working}/magic_thesis/results/evaluation_assembly/busco_results/busco_downloads/lineages/eudicotyledons_odb12 -c 4 -o ${num}_busco -m genome"
done

