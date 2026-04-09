for j in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/*.fa`
do
        i="${j##*assemblies/}"
        tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
        cp -r $j ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i
        cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TEanno.sum ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.TEanno.sum
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TElib.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.TElib.fa
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.TElib.novel.fa ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.TElib.novel.fa
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.raw ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.raw
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.combine ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.combine
cp -r ${path_to_working}/magic_thesis/intermediate_data/annotation/edta/${num}_edta/$i.mod.EDTA.anno ${path_to_working}/magic_thesis/intermediate_data/annotation/pan_edta/$i.mod.EDTA.anno
done



