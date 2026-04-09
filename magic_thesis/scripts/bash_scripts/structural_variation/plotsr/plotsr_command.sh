echo "plotsr --sr TAIR10-Col-PEK_syri/TAIR10-Col-PEK_syri.out \\"
echo "--sr Col-PEK-22571_syri/Col-PEK-22571_syri.out \\"
for i in {2..8}
do
SLURM_ARRAY_TASK_ID=$i
ref_pos=$(( ${SLURM_ARRAY_TASK_ID}-1 ))
ref_name=$(sed -n "${ref_pos}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
qry_name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ${path_to_working}/magic_thesis/meta_info/samples.txt)
fasta_loc=${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies
tmp="${ref_name##*reads.}"
ref_num="${tmp%%_*}"
tmp="${qry_name##*reads.}"
qry_num="${tmp%%_*}"
prefix="${ref_num}-${qry_num}"
echo "--sr ${prefix}_syri/${prefix}_syri.out \\"
done

echo "--sr 76789-TAIR12_syri/76789-TAIR12_syri.out \\"
echo "--cfg base.cfg -H 15 -W 20 --chrord chr_order.txt \\"
echo "--genomes genomes.txt -o plotsr.png"


