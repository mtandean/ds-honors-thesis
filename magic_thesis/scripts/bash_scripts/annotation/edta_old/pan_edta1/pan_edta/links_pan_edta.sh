for i in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/*.fa`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
ln -s ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TEanno.sum ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TEanno.sum 
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod 
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TElib.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TElib.fa 
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TElib.novel.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.TElib.novel.fa 
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.raw ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.raw 
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.combine ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.combine
ln -s ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.anno ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/$i.mod.EDTA.anno 
done

