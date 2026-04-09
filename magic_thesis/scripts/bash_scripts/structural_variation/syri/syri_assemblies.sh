for i in `ls ${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/*.fa`
do
tmp="${i##*reads.}"
        num="${tmp%%_*}"
	seqkit grep -r -p "Chr[12345]" $i -o ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/${num}_renamed.fa

done

ln -s ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR10_filtered_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/TAIR10_renamed.fa

ln -s ${path_to_working}/magic_thesis/external_data/external_assemblies/TAIR12_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/TAIR12_renamed.fa

ln -s ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies/Col-PEK_renamed.fa



