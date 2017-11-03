### Step 1. Get MONOD through git

If you don't already have git, install it with this command:

```
$ apt-get install git

```

For Federa distributions of Linux, you can use yum to install git

```
$ yum install git

```

Now in a directory that you want to work in, download MONOD with this command:

```
$ git clone https://github.com/dinhdiep/MONOD2.git

```

### Step 2. Prepare list of paths to all your BAM files. Below, I have indicated that there are four BAM files in the folder named "BAMfiles" that is located in one directory above. Make sure to provide the correct Linux paths to your BAM files to ensure that they can be found. This software have been tested only on BAM files generated using BisReadMapper, other aligner may result in erroneous methylation haplotype calls.

Example list:

```
  ../BAMfiles/CCT.100K.4643.bam.0.10.bam
  ../BAMfiles/CCT.100K.5474.bam.0.10.bam
  ../BAMfiles/CCT.100K.5893.bam.0.10.bam
  ../BAMfiles/CCT.100K.9177.bam.0.10.bam

```

### Step 3. We have provided a simple getting started script, "getting_started.sh", in the example folder to demonstrate how a pipeline from bam to MHL matrix works. If you want to modify the script to process your own samples, you must make sure the following settings are correct. For examples, the current settings are as follows:

```
  scripts_dir="../scripts"
  bamfiles_list="cct"
  metric="MHL"
  target_file="small.mhbs.txt"
  cpg_pos="../allcpg/hg19.fa.allcpgs.txt.gz"
  outname="cct"

```

Here we've specified that the MONOD scripts are found in the "scripts" folder that is one directory above. 
The list of bam files is named "cct" and is in the current working directory ("example" folder). 
The metric to compute average methylation is "MHL" or methylation haplotype load. 
The target file is "small.mhbs.txt" which is a BED format file (chr <tab> start <tab> end positions) that lists the regions to summarize methylation over. 
The CpG position file is "hg19.fa.allcpgs.txt.gz" which is found in the "allcpg" folder one directory above. Note that the CpG position file can be generated using the genomePrep.pl Perl program (same as the one for BisReadMapper). 
The output file prefix name is "cct" in the example.

To start the pipeline, run the following command in the "example" directory:

```
$ ./getting_started.sh 

```

The primary output is a methylation matrix file named "cct.mhl.txt". 
Haplotype files would be generated in the same directory as the BAM files. 
There should be two haplotype files per sample. One including all the haplotypes from the BAM file and another including only the haplotypes overlapping with the target regions from the target file (*merged*). 
You should also find a file name "cct.hap_list.merged" that will allow you to rerun cghap2matrix.sh to get different methylation matrices if you want. 
For example, below I am generating a "IMF" or individual methylation frequency per site (within target bed regions). 
The output matrix file will be named "cct.imf.txt".
Other information such as the AMF or average weighted frequency can be generated using "AMF" instead. 

```
$ ../scripts/cghap2matrix.sh cct.hap_list.merged IMF cct 

```

