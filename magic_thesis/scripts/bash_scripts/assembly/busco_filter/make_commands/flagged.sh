for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
        tmp="${i##*reads.}"
num="${tmp%%_*}"
        echo "busco -c 1 -i ${path_to_working}/magic_thesis/intermediate_data/assembly/flagged_contigs/${i}_flagged.asm.bp.p_ctg.fa -m genome -l ${path_to_working}/magic_thesis/external_data/external_lineages/eudicotyledons_odb12 --out_path ${path_to_working}/magic_thesis/intermediate_data/assembly/busco_organelle_test -o ${num}_organelle_busco"

done

