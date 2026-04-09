for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	echo "ragtag.py  scaffold ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_plus_organelles_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/assembly/ragtag/${num}_ragtag -t 3"
	
done

