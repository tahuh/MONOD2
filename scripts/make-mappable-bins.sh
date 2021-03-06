#!/bin/bash

# This software is Copyright © 2017 The Regents of the University of California. All Rights Reserved.
# Permission to copy, modify, and distribute this software and its documentation for educational, research and non-profit purposes, without fee, and without a written agreement is hereby granted, provided that the above copyright notice, this paragraph and the following three paragraphs appear in all copies.
# Permission to make commercial use of this software may be obtained by contacting:
# Office of Innovation and Commercialization
# 9500 Gilman Drive, Mail Code 0910
# University of California
# La Jolla, CA 92093-0910
# 858) 534-5815
# invent@ucsd.edu
# This software program and documentation are copyrighted by The Regents of the University of California. The software program and documentation are supplied "as is", without any accompanying services from The Regents. The Regents does not warrant that the operation of the program will be uninterrupted or error-free. The end-user understands that the program was developed for research purposes and is advised not to rely exclusively on the program for any reason.
# IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.


echo $0

path=$1
mindepth=$2

if [ -z "$2" ]
then
        echo "usage: $0 [bam file] [minimum depth cutoff]"
        exit 0
fi

name=$(basename "$path" ".bam")
echo "$name"
bedtools="bedtools"

$bedtools genomecov -bg -split -ibam $path | awk -v min=$mindepth  '$4>=min { print $1"\t"$2"\t"$3}' | $bedtools merge -d 10 -i - | awk '$3-$2>80 {print $1"\t"$2"\t"$3"\t"$3-$2+1}' > results/$name.RD${mindepth}_80up.genomecov.bed
