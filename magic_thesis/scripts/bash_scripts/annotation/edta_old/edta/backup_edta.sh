for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/* ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta_individual_backup/
done

