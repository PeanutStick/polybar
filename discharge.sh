#! /bin/bash

#a=$(upower -i `upower -e | grep 'BAT'` |grep "time to")
#echo [$a ]


b=$(acpi -b)
ch=`acpi -b|awk '{print $4}'`
if [[ $b == *"Charging"* ]]; then
	echo -n "[ ${ch::-1} ▲ "
else
	echo -n "[ ${ch::-1} ▼ "
fi

echo $b|awk '{print $5" ]"}'
#echo
#echo $time
#echo  'sdf'

