#!/bin/bash


#取出一天前的日期
d2=`date -d '2 days ago' | awk '{print $3}'`

#删除一天前所有的索引
curl -XDELETE "http://172.18.255.67:9200/*${d2}"
