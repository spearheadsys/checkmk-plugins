#!/bin/bash
host_hostalias=`lq "GET hosts\nFilter: host_name ~ pdu\nColumns: name host_alias" |tr ";" " "`
hostnames=`lq "GET hosts\nFilter: host_name ~ pdu\nColumns: name"`
for hostname in $hostnames
do
   echo "<<<<"$hostname">>>>"
   echo "<<<"rack_power">>>"
   alias=`lq "GET hosts\nFilter: host_name ~ $hostname\nColumns:host_alias"`
   rack=${alias:0:31}
   echo $rack `lq "GET services\nFilter: description ~ Input Summary\nAND\nFilter: host_alias ~ $rack\nAND\nFilter: state < 3\nStats: sum perf_data"`   
   echo "<<<<>>>>"
done
