for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	cp ${path_to_working}/magic_thesis/intermediate_data/temp/${num}_scaffolded/ragtag.scaffold.fasta ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${i}.asm.bp.p_ctg.ragtag.scaffold.fa
done

