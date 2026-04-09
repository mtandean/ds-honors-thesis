
for j in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/*.fa`
do
	i="${j##*contig_assemblies/}"
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
	rmlib_loc="${path_to_working}/magic_thesis/intermediate_data/annotation/repeat_modeler/${num}_repeat_modeler/${num}_db-families.fa"
curatedlib_loc="${path_to_working}/magic_thesis/external_data/external_annotations/athrep.updated.fasta_073025"
cds_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_cds_from_genomic.fna
	echo "perl ~/bin/EDTA/EDTA.pl --genome ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/$i --curatedlib $curatedlib_loc --cds $cds_loc --anno 1 --rmlib  $rmlib_loc --threads 31 --evaluate 1 --u 7.0e-9"

done

