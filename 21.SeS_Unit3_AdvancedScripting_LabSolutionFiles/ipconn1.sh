#! /bin/sh
IFS=,

# Loop through the csv file, printing the date and time fields.
while read CONN DATE TIME DURATION PROTO SRCPORT DESTPORT SRCIP DESTIP ATTACK TYPE
do
	echo "The date is $DATE and the time is $TIME"
done < connect.csv
exit 0
