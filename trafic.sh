down=$(awk '{if(l1){print ($2-l1)/1024} else{l1=$2; l2=$10;}}' \
    <(grep wlp7s0 /proc/net/dev) <(sleep 1; grep wlp7s0 /proc/net/dev))
upl=$(awk '{if(l1){print ($10-l2)/1024} else{l1=$2; l2=$10;}}' \
<(grep wlp7s0 /proc/net/dev) <(grep wlp7s0 /proc/net/dev))

d=$(printf "%.2f\n" ${down//./,}) 
u=$(printf "%.2f\n" ${upl//./,})
if [[ $d > 1000 ]]
then
	d=$(echo "$d" | cut -d ',' -f1)
	d=$((($d+512)/1024))"MB/s"
else
	d=$d"kB/s"
fi
if [[ $u > 1000 ]]
then
        u=$(echo "$u" | cut -d ',' -f1)
        u=$((($u+512)/1024))"MB/s"
else
	u=$u"kB/s"
fi
	echo "[ ▼ "$d" ▲ "$u" ]"
