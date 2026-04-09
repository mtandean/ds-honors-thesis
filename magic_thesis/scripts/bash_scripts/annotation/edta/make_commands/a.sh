for i in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/*.fa`
do
	tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
curatedlib_loc="${path_to_working}/magic_thesis/external_data/external_annotations/athrep.updated.fasta_073025"
cds_loc=${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_cds_from_genomic.fna
	echo "perl ~/bin/EDTA/EDTA.pl --genome $i --curatedlib $curatedlib_loc --cds $cds_loc --anno 1 --threads 23 --sensitive 1 --u 7.0e-9"

done

