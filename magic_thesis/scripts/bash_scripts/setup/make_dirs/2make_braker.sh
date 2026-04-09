for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	mkdir ${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker_renamed
done

