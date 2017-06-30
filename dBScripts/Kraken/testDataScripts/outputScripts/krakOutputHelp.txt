
OUTPUT FORMAT
=============

Each sequence classified by Kraken results in a single line of
output.  Output lines contain five tab-delimited fields; from
left to right, they are:

  1) "C"/"U": one letter code indicating that the sequence was
     either classified or unclassified.
  2) The sequence ID, obtained from the FASTA/FASTQ header.
  3) The taxonomy ID Kraken used to label the sequence; this is
     0 if the sequence is unclassified.
  4) The length of the sequence in bp.
  5) A space-delimited list indicating the LCA mapping of each k-mer
     in the sequence.  For example, "562:13 561:4 A:31 0:1 562:3"
     would indicate that:
     - the first 13 k-mers mapped to taxonomy ID #562
     - the next 4 k-mers mapped to taxonomy ID #561
     - the next 31 k-mers contained an ambiguous nucleotide
     - the next k-mer was not in the database
     - the last 3 k-mers mapped to taxonomy ID #562
