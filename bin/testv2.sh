#!/bin/bash

# This script tests Version 2 of the EZID API.
# It is called by monitorv2.sh.

PATH="/cdlcommon/products/bin:$PATH" export PATH

Wget='wget -q -O -'

# These are extremely primitive tests!
astatus=`$Wget http://n2t.net/ezid/status 2>&1`
nstatus=`$Wget http://noid.cdlib.org/nd/noidu_g3 2>&1`
ustatus=`$Wget http://n2t.net/ezid 2>&1`

asuccess=`echo "$astatus" | sed -n 's/.*success.*/1/p'`
nsuccess=`echo "$nstatus" | sed -n 's/.*Usage.*/1/p'`
usuccess=`echo "$ustatus" | sed -n 's/.*encoding.*/1/p'`

Date=`date '+%Y%m%d%H%M%S'`

if [ "$asuccess" = "1" -a "$nsuccess" = "1" -a "$usuccess" = "1" ]
then
	echo "$Date ok:"
else
	echo "$Date notok:"
	echo "ui: $usuccess: $ustatus"
	echo "api: $asuccess: $astatus"
	echo "noid:  $nsuccess: $nstatus"
fi
