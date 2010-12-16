#!/bin/bash

# This script monitors Version 2 of EZID (API + UI) by calling testv2.sh.
# Output is formatted to be sent as email, including a distinguished
# Subject line.  It is called by crontab with something like:
#   9 * * * * /n2t/apache/bin/monitorv2.sh

#Notify="jak@ucop.edu joan.starr@ucop.edu gjanee@alexandria.ucsb.edu"
# Added Joan at her request to an address that she can check with her
# blackberry.
Notify="jak@ucop.edu joanbstarr@gmail.com"
Log=/n2t/apache/logs/monitorlog

Test=`/n2t/apache/bin/testv2.sh`

# $Test should start with a timestamp like this: 20100703103551
# Near 5am pacific/8am eastern (once a day) we notify of a successful test.
# Otherwise, we only notify of unsuccessful tests.

S=`echo "$Test" | sed -n -e 's/^........11.... ok:$/2/p' -e 's/.* ok:$/1/p'`

if [ "$S" = 2 ]
then
	(
		echo "Subject: [ezid-ok] api/ui and binder alive"
		echo ""
		echo This is a once-a-day check pulse check.
	)			| mail $Notify
elif [ "$S" != 1 ]
then
	(
		echo "Subject: [ezid-notok] api/ui and/or binder problem"
		echo ""
		echo $Test
	)			| mail $Notify
fi

echo $Test >> $Log
