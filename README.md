# Tasmota Flasher
The fastest way to flash Tasmota to ESP32 and ESP8266 with the current firmware everytime. Tested under Ubuntu 20.04.2 LTS.  Just run script and it will download all the required firmware files and install all of the apt depends. This script can also set all settings such as template and wifi settings.

# How to use

Everything is done in 1 step:

```
./flash.sh 
```

New users might have to give root password to install apt depends such as subversion, esptool, etc...

Example output
```
Detected /dev/ttyUSB0 ESP8266 on wifi
esptool.py v2.8
Serial port /dev/ttyUSB0
Connecting....
Chip is ESP8266EX
Features: WiFi
Crystal is 26MHz
MAC: xx:xx:xx:xx:xx:xx
Enabling default SPI flash mode...
Configuring flash size...
Erasing flash...
Took 2.47s to erase flash block
Wrote 622592 bytes at 0x00000000 in 61.5 seconds (81.0 kbit/s)...

Leaving...
Hard resetting via RTS pin...
Wating for boot (5 sec)...
```
# Sending wifi,template and other details:

Edit tasmota_flasher.config

Example:

```
###############################3
# This File can be located in project dir "./" or user config dir "~/.config/tasmota_flasher/tasmota_flasher.config"
# Project dir will set defaults and user dir will overwrite

# firmware_file=tasmota.bin

# Passwords are limited to 64 characters. Do not use special characters or white spaces in the password.
# Do not use special characters or white spaces in the SSID
#device_config_ssid1=
#device_config_password1=
#device_config_ssid2=
#device_config_password2=

url_git_tasmota=https://github.com/arendst/Tasmota/
dir_temp=~/.cache/tasmota_flasher
dir_config_dir=~/.config/tasmota_flasher

device_write_flash=true
device_write_config=true
```
