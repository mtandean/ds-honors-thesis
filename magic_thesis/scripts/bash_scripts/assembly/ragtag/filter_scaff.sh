for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	sed 's/^>\(Chr[12345]\)_RagTag/>\1/g' ${path_to_working}/magic_thesis/intermediate_data/assembly/ragtag/${num}_ragtag/ragtag.scaffold.fasta > ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/temp_${i}.asm.bp.p_ctg.scaffold.fa
	seqkit grep -r -p "[^PM].*"  ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/temp_${i}.asm.bp.p_ctg.scaffold.fa -o ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${i}.asm.bp.p_ctg.scaffold.fa
	rm ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/temp_${i}.asm.bp.p_ctg.scaffold.fa
done

