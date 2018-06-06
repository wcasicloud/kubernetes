#!/bin/bash
#author liuwei
#Check Nginx Service scripts
ngx_run=`ps -C nginx --no-header | wc -l`
check_ngx() {
	if [ $ngx_run -eq 0 ]; then
		systemctl start nginx
		sleep 3
	fi
}
check_ngx
