for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
output_dir=${path_to_working}/magic_thesis/intermediate_data/annotation/braker/${num}_braker
protein_loc=${path_to_working}/magic_thesis/external_data/external_annotations/braker_ortho_db/braker_proteins.fa
masked_genome_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/softmasked_genomes/${num}_repeatmasker/${i}.asm.bp.p_ctg.scaffold.fa.masked

echo "apptainer exec  ${path_to_working}/apptainer_dir/braker3.sif braker.pl --genome=$masked_genome_loc --prot_seq=$protein_loc --workingdir=$output_dir --AUGUSTUS_CONFIG_PATH=${path_to_working}/apptainer_dir/Augustus/config --GENEMARK_PATH=~/bin/GeneMark-ETP/bin/gmes --threads=31 --useexisting --species arabidopsis"

done

