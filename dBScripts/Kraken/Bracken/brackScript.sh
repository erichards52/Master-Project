kraken --db=/home4/rich01e/ratKrakDB/HumanVirusBacteriaRat/ --fasta-input --threads=10 <( find -L /home4/rich01e/ratKrakDB/HumanVirusBacteriaRat/library/added/ -name "*.fna" -exec cat {} + )  > database.kraken
perl count-kmer-abundances.pl --db=/home4/rich01e/ratKrakDB/HumanVirusBacteriaRat/ --read-length=75 --threads=10 /home4/rich01e/ratKrakDB/testKrak/kraken/database.kraken > database75mers.kraken_cnts
python generate_kmer_distribution.py -i database75mers.kraken_cnts -o abundest_krak.TXT
