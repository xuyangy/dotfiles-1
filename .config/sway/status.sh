while 
  cpu_temp=$(cat /proc/acpi/ibm/thermal | grep -oP "\d+" | head -1)
  battery_capacity=$( cat /sys/class/power_supply/BAT0/capacity )
  date=$( date +'%Y-%m-%d %k:%M:%S' )
  echo T:$cpu_temp B:$battery_capacity $date 
do sleep 1; 
done

