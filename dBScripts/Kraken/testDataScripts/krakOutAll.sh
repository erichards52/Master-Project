kraken --preload --threads 12 --fastq-input --paired --db ~/ratKrakDB/HumanVirusBacteriaRat ~/faFiles/homoResp/1H7_S22_L001_R1.fq ~/faFiles/homoResp/1H7_S22_L001_R2.fq > /home4/rich01e/faFiles/krakenOutput/krakenHomoResp

kraken --preload --threads 12 --fastq-input --paired --db /home4/rich01e/ratKrakDB/HumanVirusBacteriaRat/ /home4/rich01e/faFiles/sraFiles/SRR062415_1.fastq /home4/rich01e/faFiles/sraFiles/SRR062415_2.fastq > /home4/rich01e/faFiles/krakenOutput/krakenSaliva062415

kraken --preload --threads 12 --fastq-input --paired --db /home4/rich01e/ratKrakDB/HumanVirusBacteriaRat /home4/rich01e/faFiles/sraFiles/SRR062462_1.fastq /home4/rich01e/faFiles/sraFiles/SRR062462_2.fastq > /home4/rich01e/faFiles/krakenOutput/krakenSaliva062462

kraken --preload --threads 12 --fastq-input --paired --db ~/ratKrakDB/HumanVirusBacteriaRat ~/faFiles/midgeNov/midge1-0167e2_S9_L001_R1_001.fastq ~/faFiles/midgeNov/midge1-0167e2_S9_L001_R2_001.fastq > /home4/rich01e/faFiles/krakenOutput/krakenMidgeNov

kraken --preload --threads 12 --fastq-input --paired --db ~/ratKrakDB/HumanVirusBacteriaRat ~/faFiles/travChik/S18_R1.fq ~/faFiles/travChik/S18_R2.fq > /home4/rich01e/faFiles/krakenOutput/krakenTravChik




