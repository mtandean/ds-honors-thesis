for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	mv ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta_individual_backup/* ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta

done

