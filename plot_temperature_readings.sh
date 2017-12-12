#!/bin/sh
#
# Process readtemp.py data found from one-wire sensors
#
# Rick van der Zwet <info@rickvanderzwet.nl>
#

# Split sensor data on per file basis and delete incorrect values
for sensor in $(awk -F ';' '{print $2}' DHT_DATA_2017_*.csv  | sort -u); do
	grep -h $sensor DHT_DATA_2017_*.csv  | tr ';' ' ' | awk '{if ($3 > 10000 && $3 < 70000) print $0}'  > sensor-$sensor.txt
done

echo "# Sensors in use are"
	ls -1 sensor-*.txt


# TODO: Make sure to use your own title and sensor IDs for data visualisation
gnuplot <<'EOF'
  set title 'Temperature Readings'
  set xdata time
  set timefmt "%s"
  set grid
  plot 	"sensor-28-04165895f8ff.txt" using ($1 + 3600):($3 / 1000) with lines title 'CV aanvoer' lt rgb 'red', \
	"sensor-28-031655c9d5ff.txt" using ($1 + 3600):($3 / 1000) with lines title 'CV retour' lt rgb 'blue', \
	"sensor-28-031655da29ff.txt" using ($1 + 3600):($3 / 1000) with lines title 'Ruimte temperatuur' lt rgb 'green'
  pause 100
EOF
