down=$(awk '{if(l1){print ($2-l1)/1024} else{l1=$2; l2=$10;}}' \
    <(grep wlp7s0 /proc/net/dev) <(sleep 1; grep wlp7s0 /proc/net/dev))
upl=$(awk '{if(l1){print ($10-l2)/1024} else{l1=$2; l2=$10;}}' \
<(grep wlp7s0 /proc/net/dev) <(grep wlp7s0 /proc/net/dev))
ms=$(ping -c 1 1.1.1.1 |awk 'FNR==2{print $6}' | cut -c7- )

d=$(printf "%.2f\n" ${down//./,}) 
u=$(printf "%.2f\n" ${upl//./,})
d=$(echo $d | cut -f1 -d",")
u=$(echo $u | cut -f1 -d",")
if [[ $d -gt 1000 ]]
then
	d=$((($d+512)/1024))"MB/s"
else
	d=$d"kB/s"
fi
if [[ $u -gt 1000 ]]
then
        u=$((($u+512)/1024))"MB/s"
else
	u=$u"kB/s"
fi
	echo "[ ▼ "$d" ▲ "$u" "$ms" ]"
