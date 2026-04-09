for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
filt_path="${path_to_working}/magic_thesis/intermediate_data/assembly/organelle_filter"
	
awk '{ if ($10/$2 > 0.5) print $1 }' ${filt_path}/alignments/${num}_organelle_alignments.paf | sort | uniq > ${filt_path}/organelle_contig_names/${num}_organelle_contig_names.txt;  seqkit grep -v -f ${filt_path}/organelle_contig_names/${num}_organelle_contig_names.txt    ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/${i}.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa
done

