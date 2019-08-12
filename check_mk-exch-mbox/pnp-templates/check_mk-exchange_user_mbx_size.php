<?php
#
# Copyright (c) 2006-2010 Joerg Linge (http://www.pnp4nagios.org)
# Plugin: check_load
#
$opt[1] = "--vertical-label \"Size in MB\" -X0 -b1024 -l0 --title \"Mailbox Size $servicedesc\" ";
$def[1] = "DEF:var1=$RRDFILE[1]:$DS[1]:MAX ";
if ($WARN[1] != "") {
    $def[1] .= "HRULE:$WARN[1]#FFFF00:\"Warning\: $WARN[1]MB\" ";
    $def[1] .= "HRULE:$CRIT[1]#FF0000:\"Critical\: $CRIT[1]MB\" ";
}
$def[1] .= rrd::area("var1", "#EACC00", "size ") ;
$def[1] .= rrd::gprint("var1", array("LAST", "AVERAGE", "MAX"), "%6.0lf MB");
?>
