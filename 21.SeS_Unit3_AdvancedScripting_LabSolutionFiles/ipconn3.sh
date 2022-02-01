#! /bin/sh
IFS=,
COUNT=0

while read CONN DATE TIME TIMESTAMP DURATION PROTO SRCPORT DESTPORT SRCIP DESTIP ATTACK TYPE
do
	# Assign beginning timestamp to first element in the list.
	# Assign ending timestamp to every non-first element so that it equals the final time at the end of the loop.
	if [ $COUNT -eq 1 ]
	then
		BEGINTIMESTAMP="$TIMESTAMP"
	else
		ENDTIMESTAMP="$TIMESTAMP"
	fi
	COUNT=`expr $COUNT + 1`
done < connect-ts.csv

# Calculate duration.
DUR=`expr $ENDTIMESTAMP - $BEGINTIMESTAMP`

# Print timestamps, and duration.
echo "Begin: $BEGINTIMESTAMP; End: $ENDTIMESTAMP; Duration: $DUR seconds (`expr $DUR / 3600`:`expr $DUR / 60 % 60`:`expr $DUR % 60`)"
exit 0