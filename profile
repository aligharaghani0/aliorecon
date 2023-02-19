#!/bin/bash

echo " massDns is working ( dns resolver )  " 


massdns  -o S -t A  -r resolver.txt  allsub-target.txt  > massdns-output-targe.txt
# use file for ip calculating 
massdns  -o S -t A  -r resolver.txt  allsub-target.txt   | cut -d " " -f1 | sed "s/\.$//g"  > all-dnsresolved-targe.txt

#echo " you select the level 2 so dnsgen is working on the massdns result's " 
#cat live-target.txt  | dnsgen -  | massdns -t A -o S  -r resolver.txt | cut -d " " -f1 | sed "s/\.$//g"  > dnsgen-mass-target.txt 
# add dns gen for out put of the mass dns 

echo " httprobe is find live subdomain's :"
cat all-dnsresolved-targe.txt | httprobe > live-target.txt 


echo " the dnsgen is working on the httprobe output (level 1 ) "

cat live-target.txt  | dnsgen -  | massdns -t A -o S  -r resolver.txt  	| httprobe > live-dnsgen-mass-target.txt  
#test it 


echo " you are in the CDN check mode :) " 



