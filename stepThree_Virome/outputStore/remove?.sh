for i in *?.tsv
do
    mv -f "$i" "`echo $i | sed 's/?//'`"
done
