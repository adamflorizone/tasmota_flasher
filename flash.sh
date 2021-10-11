source ./tasmota_flasher.config

dir_tasmota32=${dir_temp}/tasmota32
dir_tasmota=${dir_temp}/tasmota

# dir_esptool=${dir_temp}/esptool

# USE_ESPTOOL_PIP

mkdir -p ${dir_temp}

# 
# cat urls/ESP32_needed_files.txt | parallel --gnu "wget --directory-prefix=tmp/ESP32_needed_files {}"

if [ "$device_write_flash" = true ]; then
    [ -x "$(command -v svn)" ] || (echo "We need to: sudo apt install subversion" && sudo apt install subversion)
    
    if [ "$device_type" = "ESP8266" ]; then
        mkdir -p ${dir_tasmota}
        firmware_file=${firmware_file:-'tasmota.bin'}

        [ -f "${dir_tasmota}/${firmware_file}" ] || wget "${url_firmware_file}/${firmware_file}" -P ${dir_tasmota}/

        esptool.py --chip esp8266 --port "$device_port" write_flash -fs 1MB -fm dout 0x0 "${dir_tasmota}/$firmware_file"
    elif [ "$device_type" = "ESP32" ]; then
        mkdir -p ${dir_tasmota32}
        firmware_file=${firmware_file:-'tasmota32.bin'}

        svn checkout "${url_git_tasmota}branches/master/tools/Esptool/ESP32"  ${dir_tasmota32}/ESP32_needed_files
        [ -f "${dir_tasmota32}/${firmware_file}" ] || wget "${url_firmware_file}${firmware_file}" -P ${dir_tasmota32}/

        esptool.py --chip esp32 --port "$device_port" --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dout --flash_freq 40m --flash_size detect 0x1000 "${dir_tasmota32}/ESP32_needed_files/bootloader_dout_40m.bin" 0x8000 "${dir_tasmota32}/ESP32_needed_files/partitions.bin" 0xe000 "${dir_tasmota32}/ESP32_needed_files/boot_app0.bin" 0x10000  "${dir_tasmota32}/$firmware_file"
    else
        echo Unknown Device Type
    fi
fi

./program.sh