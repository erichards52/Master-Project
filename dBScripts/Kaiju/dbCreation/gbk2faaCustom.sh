find /home4/rich01e/kaiju/kaiju/kaijudb/faaFiles/ -name "*.gz" | xargs -n 5 -i /home4/rich01e/kaiju/kaiju/kaijudb/gbk2faa.pl '{}' '{}'.faa

