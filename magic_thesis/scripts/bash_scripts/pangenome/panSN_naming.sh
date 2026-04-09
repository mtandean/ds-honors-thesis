for i in  `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
tmp="${i##*reads.}"
        num="${tmp%%_*}"
seqkit replace -p "^" -r "${num}#1#" ${path_to_working}/magic_thesis/intermediate_data/assembly/filtered_contig_assemblies/${i}_nuclear.asm.bp.p_ctg.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/${num}_panSN_spec.fa
done



seqkit replace -p "^" -r "TAIR12#1#" ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR12_renamed.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/TAIR12_panSN_spec.fa


seqkit replace -p "^" -r "Col-PEK#1#" ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa -o ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/Col-PEK_panSN_spec.fa
