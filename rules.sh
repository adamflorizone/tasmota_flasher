source ./tasmota_flasher.config

# echo "Mem10 c1f0s1p30" | ./sendCommand.sh "$device_port" "$device_baud"
cat custom_builds/DISPLAY_SSD1306/rule2.txt | ./sendCommand.sh "$device_port" "$device_baud"
cat custom_builds/DISPLAY_SSD1306/rule3.txt | ./sendCommand.sh "$device_port" "$device_baud"
echo "Backlog rule1 on; rule2 on; rule3 on; DisplayAddress 0x3c; DisplayModel 2; DisplayDimmer 100; DisplayMode 0; mqtthost 192.168.1.178; mqttport 1983; mqttuser DVES_USER; mqttpassword cP3453FPf4kd; topic tasmota_%06X" | ./sendCommand.sh "$device_port" "$device_baud"


