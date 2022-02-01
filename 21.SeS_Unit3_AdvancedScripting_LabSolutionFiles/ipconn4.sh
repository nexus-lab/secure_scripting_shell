#! /bin/sh
IFS=,
COUNT=0
RESULT=connect-host.csv

# If the result file exist, delete it.
if [ -e $RESULT ]
then
	rm "$RESULT"
fi

# Loop through file, find and print the destination name and save to a new file named connect-host.csv
while read CONN DATE TIME DURATION PROTO SRCPORT DESTPORT SRCIP DESTIP ATTACK TYPE
do
	if [ $COUNT -ne 0 ]
	then
		DESTNAME=`echo $DESTIP | sed -f hostmap.sed`
	else
		DESTNAME="DESTINATION NAME"
	fi
	echo "$CONN,$DATE,$TIME,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$DESTIP,$DESTNAME,$ATTACK,$TYPE"
	echo "$CONN,$DATE,$TIME,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$DESTIP,$DESTNAME,$ATTACK,$TYPE" >> connect-host.csv
	COUNT=`expr $COUNT + 1`
done < connect.csv
exit 0
