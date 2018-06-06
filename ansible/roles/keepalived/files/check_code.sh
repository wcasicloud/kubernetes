#!/bin/bash
#author liuwei
#Check Nginx Service scripts
uc_url=http://uc.casicloud.com
count=0
check_code() {
	for (( k=0; k<2; k++ ))
	do
		code=$( curl --connect-timeout 3 -sSL -w "%{http_code}\\n" $uc_url -o /dev/null )
		if [ "$code" != "200" ]; then
			count=$(expr $count + 1)
			sleep 3
			continue
		else
			count=0
			break
		fi
	done
	
	if [ "$count" != "0" ]; then
		systemctl start nginx
		exit 1
	else
		exit 0
	fi	
}

check_code
