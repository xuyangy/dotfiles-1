while 
  date=$( date +'%Y-%m-%d %k:%M:%S' )
  battery_capacity=$( cat /sys/class/power_supply/BAT0/capacity )
  echo $battery_capacity $date 
do sleep 1; 
done

