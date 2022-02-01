#! /bin/sh
IFS=,
COUNT=0
RESULT=connect-ts.csv

# If the result file already exist from a previous script, delete it.
if [ -e $RESULT ]
then
	rm "$RESULT"
fi

while read CONN DATE TIME DURATION PROTO SRCPORT DESTPORT SRCIP DESTIP ATTACK TYPE
do
	# If the count doesn't equal 0, a timestamp is created, if count equals 0, timestamp is simply the word TIMESTAMP.
	if [ $COUNT -ne 0 ]
	then
		TIMESTAMP=`date "-d$DATE $TIME" +%s`
	else
		TIMESTAMP="TIMESTAMP"
	fi
    echo "$CONN,$DATE,$TIME,$TIMESTAMP,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$DESTIP,$ATTACK,$TYPE"
	echo "$CONN,$DATE,$TIME,$TIMESTAMP,$DURATION,$PROTO,$SRCPORT,$DESTPORT,$SRCIP,$DESTIP,$ATTACK,$TYPE" >> connect-ts.csv

	# Add 1 to count.
	COUNT=`expr $COUNT + 1`

done < connect.csv
exit 0
