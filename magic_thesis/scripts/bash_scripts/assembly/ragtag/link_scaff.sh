for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	ln -s ${path_to_working}/intermediate_data/assembly/ragtag/${num}_ragtag/ragtag.scaffold.fa ${path_to_working}/intermediate_data/assembly/scaffolded_assemblies/${i}.asm.bp.p_ctg.scaffold.fa
done

