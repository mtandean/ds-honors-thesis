for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
echo "minimap2 -t 31 -x asm5 ${path_to_working}/magic_thesis/external_data/external_assemblies/organelles_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/$i.asm.bp.p_ctg.fa > ${path_to_working}/magic_thesis/intermediate_data/assembly/organelle_filter/alignments/${num}_organelle_alignments.paf" 
done

