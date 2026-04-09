for j in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/*.fa`
do
	i="${j##*assemblies/}"
        tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
ln -s $j ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.TEanno.sum ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TEanno.sum
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.TElib.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TElib.fa
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.TElib.novel.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TElib.novel.fa
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.raw ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.raw
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.combine ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.combine
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/$i.mod.EDTA.anno ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.anno
done



for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	mkdir ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta_individual_backup
done



for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta/* ${path_to_working}/magic_thesis/intermediate_data/annotation/edta1/${num}_edta_individual_backup/
done



for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
        tmp="${i##*reads.}"
        num="${tmp%%_*}"
 echo ${i}_nuclear.asm.bp.p_ctg.fa >> ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/pan_edta_genome_list.txt
done

