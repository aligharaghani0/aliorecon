#!/bin/bash





#-----------------------------------------------------------------------------
#$1 is for target.com 



#-------------------------------------------------------------------------------

echo " massDns is working ( dns resolver )  " 

puredns resolve all.txt -r  resolver.txt > dnsresolve-output-$1.txt # main mass out  put :)   # this is for saving the domain list in pure mode 
# ------------------------------------------------------------------------
 #ip proccess :) 



#-------------------------------------------------------------------------------------------------------------------------------------------------
#dns gen for mass dns records 
# save the ip's of the targes in the massdns output file :) 

#----------------------------------------------------------------------------------------------------------------------------------------
#httpx modex 

echo "httpx mode :)    " 

cat dnsresolve-output-$1.txt | httpx  -s -cdn > httpx-output-$1.txt 

cat  httpx-output-$1.txt | cut -d " " -f1 > live-$1.txt # this is main file 


cat httpx-output-$1.txt | grep  -v -E '\[\D*\]' > $1-CDNless.txt 
len_cdnless=$( wc -l $1-CDNless.txt )
if [len_cdnless != 0 ] ; then 
	echo $len_cdnless "  of the domain's is not under the CDN aliorec is make list of this :) "
else 
	rm -rf $1-CDNless.txt 
	echo " all of the subdomai's is under the CDN securly :) "
fi 

#----------------------------------------------------------------------




#------------------------------------------------------------------------


if [ $2 == "3" ]; then 
	echo "level 3 ---> dnsgen on the httpx resuls " ; 
	dnsgen live-$1.txt 	| puredns resolve -r resolver.txt  > puredns-dnsgen-live-$1.txt  
	# if the len of the file is 0 delete the file and if not get it to the httpx :) to check the live :) 
	len_chekk=$(wc -l puredns-dnsgen-live-$1.txt )
	if [ len_chekk != "0" ]; then
		cat puredns-dnsgen-live-$1.txt | httprobe > dnsgen   
	else 
		echo " make the swich for thsi part of the code to delete the puredns fiel :) for 0 len :)  "
	fi

	 

elif [[ $2 == "4" ]]; then 
	echo " level 4 ----> dns gen on the dns resolver reults "

	dnsgen massdns-allsub-$1.txt | puredns resolve -r resolver.txt > puredns-dnsgen-1$.txt
	cat puredns-dnsgen-1$.txt | httprobe > live-dnsgen-dnsresolve-$1.txt 

else 
	echo " the secend argument is not true so dns gen is not working :)"
fi
 




#---------------------------------------------------------------------------






