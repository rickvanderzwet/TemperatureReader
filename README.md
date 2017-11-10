# TemperatureReader
Reading SPI one-wire DS18B20 temperature sensors with Raspberry Pi and parsing output with gnuplot

# Connectors

The following wirings are needed to be able to read the sensor from the Raspberry Pi:
 - The red wire connected to Pin 1 (3.3V)
 - The black wire connected to Pin 3 (GND)
 - The yellow wire connected to Pin 4 (#4) 
 - A pull-up resistor (4.7k ohm) connected between the red and yellow wire
 
 
 In my case if you want to connect multiple sensors simply combine wires of the same color (one one resistor is needed for the whol e batch).
 
 
