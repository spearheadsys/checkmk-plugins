#!/bin/bash
CONN=`echo "show info" | socat /var/lib/haproxy/stats stdio |grep CurrConns | cut -d' ' -f2`
SRVS=`cat /etc/haproxy/haproxy.cfg |grep check | grep server |wc -l`
if [ $CONN = 0 ]; then
	CONN=4
fi
if [ $SRVS = 0 ]; then
	echo "<<<up_scale>>>"
        echo "up_scale 1000"
	echo "<<<down_scale>>>"
        echo "down_scale 1000"
else
	let "CONNPERSRV=$CONN/$SRVS"
	echo "<<<up_scale>>>"
        echo "up_scale $CONNPERSRV"
	if [ $SRVS -le 2 ]; then
		echo "<<<down_scale>>>"
    	echo "down_scale 16"
	else
		echo "<<<down_scale>>>"
    	echo "down_scale $CONNPERSRV"
	fi

fi
