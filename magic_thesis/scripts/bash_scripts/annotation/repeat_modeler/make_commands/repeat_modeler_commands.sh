for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
	echo "apptainer exec ${path_to_working}/apptainer_dir/tetools_latest.sif BuildDatabase -name ${path_to_working}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/$i.asm.bp.p_ctg.fa"

echo "apptainer exec  ${path_to_working}/apptainer_dir/tetools_latest.sif RepeatModeler -database ${path_to_working}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db -LTRStruct -threads 15 "

done


