
for i in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
	rmlib_loc="${path_to_working}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db-families.fa"
curatedlib_loc="${path_to_working}/magic_thesis/external_data/external_annotations/athrep.updated.fasta_073025"
cds_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_cds_from_genomic.fna


	echo "perl ~/bin/EDTA/EDTA.pl --genome ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/$i --curatedlib $curatedlib_loc --cds $cds_loc --step anno --anno 1 --evaluate 1 --threads 19 --overwrite 0"
done

