loc="${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/renamed_assemblies"
rm ${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt
echo -e "$loc/TAIR10_renamed.fa\tTAIR10"  >> "${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt"
echo -e  "$loc/Col-PEK_renamed.fa\tCol-PEK" >> "${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt"



for i in `ls $loc/[0-9]*.fa`
do
	tmp=${i##*assemblies/}
	name=${tmp%%_renamed*}
	echo -e "$i\t$name" >> "${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt"

done


echo -e "$loc/TAIR12_renamed.fa\tTAIR12"  >> "${path_to_working}/magic_thesis/intermediate_data/structural_variation/syri/genomes.txt"
