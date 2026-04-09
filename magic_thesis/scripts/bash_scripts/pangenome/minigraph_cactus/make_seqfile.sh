rm ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus/cactus_list.seqfile

for i in `ls ${path_to_working}/magic_thesis/intermediate_data/pangenome/panSN_spec_genomes/*`
do
	tmp=${i##*genomes/}
	name=${tmp%%_pan*}
	echo -e "${name}\t$i" >> ${path_to_working}/magic_thesis/intermediate_data/pangenome/minigraph_cactus/cactus_list.seqfile
done

