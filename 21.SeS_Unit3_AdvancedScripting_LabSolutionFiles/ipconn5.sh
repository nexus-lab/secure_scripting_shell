#! /bin/sh
IFS=,
COUNT=0
RESULT=connect-tmp.csv

# Loop through new file, creating and adding an anonymized source ip.
while read CONN DATE TIME DURATION PROTO SRCPORT DESTPORT SRCIP DESTIP DESTNAME ATTACK TYPE
do
	if [ $COUNT -ne 0 ]
	then
		SRCANONIP=`echo $SRCIP | sed 's/\([0-9]*\)\.\([0-9]*\)\.[0-9]*.[0-9]*/\1.\2.0.0/'`
	else
		SRCANONIP="ANONYMIZED SOURCE IP"
	fi
	echo "$CONN,$DATE,$TIME,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$SRCANONIP,$DESTIP,$DESTNAME,$ATTACK,$TYPE"
	echo "$CONN,$DATE,$TIME,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$SRCANONIP,$DESTIP,$DESTNAME,$ATTACK,$TYPE" >> connect-tmp.csv
	COUNT=`expr $COUNT + 1`
done < connect-host.csv

# Overwrite old host file.
mv connect-tmp.csv ./connect-host.csv

exit 0
