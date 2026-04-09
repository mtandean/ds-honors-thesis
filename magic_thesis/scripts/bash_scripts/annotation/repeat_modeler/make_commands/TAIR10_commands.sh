for i in `ls ${path_to_working_mt}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
	echo "apptainer exec ${path_to_working_mt}/apptainer_dir/tetools_latest.sif BuildDatabase -name ${path_to_working_mt}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db ${path_to_working_mt}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i"

echo "apptainer exec  ${path_to_working_mt}/apptainer_dir/tetools_latest.sif RepeatModeler -database ${path_to_working_mt}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db -LTRStruct -threads 15"

done

