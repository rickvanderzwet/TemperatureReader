#!/bin/sh
#
# Process readtemp.py data found from one-wire sensors
#
# Rick van der Zwet <info@rickvanderzwet.nl>
#

for sensor in $(awk -F ';' '{print $2}' DHT_DATA_2017_*.csv  | sort -u); do
	grep $sensor DHT_DATA_2017_*.csv  | tr ';' ' ' > sensor-$sensor.txt
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
	"sensor-28-031655c9d5ff.txt" using ($1 + 3600):($3 / 1000) with lines title 'CV retour' lt rgb 'blue
  pause mouse close
EOF
