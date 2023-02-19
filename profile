#!/bin/bash

echo " massDns is working ( dns resolver )  " 


massdns  -o S -t A  -r resolver.txt  allsub-target.txt  > massdns-output-targe.txt
# use file for ip calculating 
massdns  -o S -t A  -r resolver.txt  allsub-target.txt   | cut -d " " -f1 | sed "s/\.$//g"  > all-dnsresolved-targe.txt

