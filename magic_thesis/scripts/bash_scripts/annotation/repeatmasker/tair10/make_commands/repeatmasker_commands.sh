for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
output_dir=${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker
panTElib_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/pan_edta_genome_list.txt.panEDTA.TElib.fa
genome_dir=${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i.asm.bp.p_ctg.ragtag.scaffold.fa
echo "apptainer exec  ${path_to_working}/apptainer_dir/tetools_latest.sif RepeatMasker -pa 14 -lib $panTElib_loc -xsmall -dir $output_dir $genome_dir"
done
