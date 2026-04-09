for j in {1..8}
do
	i=$(sed -n "${j}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
	tmp="${i##*reads.}"
        num="${tmp%%_*}"

sed "s/^>/>${num}#${j}#/" ${path_to_working}/magic_thesis/intermediate_data/assembly/contig_assemblies/${i}.asm.bp.p_ctg.fa > ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb/pggb_prep_assemblies/${i}.asm.bp.p_ctg.renamed.fa
done

sed 's/^>.*\([12345]\)/>TAIR12#0#chr\1/g' /global/home/users/mtandean/scratch/magic_thesis/external_data/external_assemblies/GCA_978657495.1_TAIR12_genomic.fna > ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb/pggb_prep_assemblies/TAIR12.renamed.fa


cd ${path_to_working}/magic_thesis/intermediate_data/pangenome/pggb/pggb_prep_assemblies

module load bio/samtools
cat *renamed.fa > ../pggb_in.fa
samtools faidx ../pggb_in.fa


