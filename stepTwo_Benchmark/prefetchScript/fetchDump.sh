#Downloads control samples from the SRA and extracts them
prefetch SRR062462
prefetch SRR062415
fastq-dump --outdir /home4/rich01e/faFiles/sraFiles/ --split-files /home4/rich01e/ncbi/public/sra/SRR062415.sra
fastq-dump --outdir /home4/rich01e/faFiles/sraFiles/ --split-files /home4/rich01e/ncbi/public/sra/SRR062462.sra

