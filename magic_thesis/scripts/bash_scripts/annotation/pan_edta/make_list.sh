for i in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/*.fa`
do
	echo $i >> ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/genome_list
done
