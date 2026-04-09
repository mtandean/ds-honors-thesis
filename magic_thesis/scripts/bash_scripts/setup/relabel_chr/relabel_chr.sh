sed 's/^>.*chromosome \([12345]\)/>Chr\1/g' ${path_to_working}/magic_thesis/external_data/external_assemblies/raw/GCA_020911765.2_ASM2091176v2_genomic.fna > ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa


cat ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_renamed.fa > ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_plus_organelles_renamed.fa

cat ${path_to_working}/magic_thesis/external_data/external_assemblies/organelles_renamed.fa >> ${path_to_working}/magic_thesis/external_data/external_assemblies/Col-PEK_plus_organelles_renamed.fa

