for i in `cat ~/scratch/magic_thesis/meta_info/samples.txt`
do
	tmp="${i##*reads.}"
        num="${tmp%%_*}"
	loc=~/scratch/magic_thesis/intermediate_data/annotation/braker
	echo "$( grep -P '\tgene\t' $loc/${num}_braker/braker.gtf | wc -l )"
done


