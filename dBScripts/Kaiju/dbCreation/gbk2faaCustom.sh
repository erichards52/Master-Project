find ./genomeFiles -name "*.gbff" | xargs -n 1 -i gbk2faa.pl '{}' '{}'.faa

