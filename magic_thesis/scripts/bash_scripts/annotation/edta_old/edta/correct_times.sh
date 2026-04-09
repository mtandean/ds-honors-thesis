for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`
do
scaff_fasta_name="m84268_250919_003033_s1.hifi_reads.22571_XW_hifiasm.asm.bp.p_ctg.ragtag.scaffold.fa"
pass_list_loc=${path_to_working}/magic_thesis/intermediate_data/annotation/edta/pan_edta/${scaff_fasta_name}.mod.EDTA.raw/LTR
awk -v old_u=1.3e-8 -v new_u=7.0e-9 'BEGIN {FS="\t"; OFS="\t"} NR==1 {print $0} NR>1 && $12 ~ /^[0-9]+(\.[0-9]+)?$/ { $12 = sprintf("%.0f", $12 * (old_u / new_u)); print $0 } 
NR>1 && $12 !~ /^[0-9]+(\.[0-9]+)?$/ { print $0 }' ${pass_list_loc}/${scaff_fasta_name}.mod.pass.list > ${pass_list_loc}/${scaff_fasta_name}.mod.corrected.pass.list
done

