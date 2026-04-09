for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	braker_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker
	awk -v OFS='\t' '$3 == "gene" {print $1, $4, $5, $9}' $braker_loc/braker.gtf > ${path_to_working}/magic_thesis/intermediate_data/annotation/genespace/bed/${num}.bed
	awk '/^>/ {if ($1 ~ /\.t1$/) {sub(/\.t1$/, ""); print; keep=1} else {keep=0}; next} keep {print}' $braker_loc/braker.aa > ${path_to_working}/magic_thesis/intermediate_data/annotation/genespace/peptide/${num}.fa
done

