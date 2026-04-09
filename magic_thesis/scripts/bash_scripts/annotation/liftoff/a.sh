for i in `cat ${path_to_working}/magic_thesis/meta_info/samples.txt`

do

        tmp="${i##*reads.}"
        num="${tmp%%_XW*}"
genome_loc=${path_to_working}/magic_thesis/intermediate_data/assembly/scaffolded_assemblies/${i}.asm.bp.p_ctg.scaffold.fa

        gff_loc="${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_genomic.gff"
ref_loc="${path_to_working}/magic_thesis/external_data/external_assemblies/raw/GCA_978657495.1_TAIR12_genomic.fna"

        echo "liftoff $genome_loc $ref_loc -o ${num}_liftoff -p 31 -db ${path_to_working}/magic_thesis/external_data/external_annotations/GCA_978657495.1_TAIR12_genomic.gff_db"
done

