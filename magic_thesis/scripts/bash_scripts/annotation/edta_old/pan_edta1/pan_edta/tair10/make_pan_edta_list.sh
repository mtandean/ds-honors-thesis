for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
 echo ${i}_hifiasm.asm.bp.p_ctg.ragtag.scaffold.fa >> ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/pan_edta_genome_list.txt
done

