#!/usr/bin/env python
#
# Read temperature of 1-wire sensors
#
import sys
import time
import csv
import glob

while True:
  csvfile = time.strftime("/home/pi/DHT_DATA_%Y_%m.csv")
  with open(csvfile, "a") as output:
    for tfile in glob.glob('/sys/bus/w1/devices/*/w1_slave'):
      sensor = tfile.split('/')[5]
      with open(tfile, 'rb') as fh:
        # $ cat /sys/bus/w1/devices/28-031655c9d5ff/w1_slave 
        # 51 01 4b 46 7f ff 0c 10 ab : crc=ab YES
        # 51 01 4b 46 7f ff 0c 10 ab t=21062
        text = fh.read()
    
      crc_valid = False
      for line in text.split('\n'):
      	if 'crc=' in line:
	   crc_valid = 'YES' in line
	elif 't=' in line:
      	   # Retreive t=(\d*) value in milli-degrees
      	   temperaturedata = line.split(" ")[9]
      	   temp = int(temperaturedata[2:])
  
      # print "sensor", sensor, "=", float(temp) / 1000, "graden. crc_valid=", crc_valid
      if crc_valid:
      	data = [int(time.time()), sensor, temp]
      	writer = csv.writer(output, delimiter=";", lineterminator='\n')
      	writer.writerow(data)

  time.sleep(5)



