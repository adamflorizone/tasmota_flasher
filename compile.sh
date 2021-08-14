source ./tasmota_flasher.config

dir_tasmota_source=${dir_temp}/tasmota_${tasmota_build_tag}

# https://tasmota.github.io/docs/Compile-your-build/

#[ -x "$(command -v git)" ] || (echo "We need to: sudo apt install git" && sudo apt install git)
#git clone https://github.com/arendst/Tasmota.git "$dir_tasmota_source"

[ -d "$dir_tasmota_source" ] || ( mkdir -p "$dir_tasmota_source.incomplete" && wget -c "https://github.com/arendst/Tasmota/archive/refs/tags/${tasmota_build_tag}.tar.gz" -O - | tar --strip-components=1 -xz -C "$dir_tasmota_source.incomplete" && mv "$dir_tasmota_source.incomplete" "$dir_tasmota_source" )


[ -x "$(command -v pip3)" ] || (echo "We need to: sudo apt install python3-pip" && sudo apt install python3-pip)
[ -x "$(command -v platformio)" ] || pip3 install platformio


#  consult the builds table for variant https://tasmota.github.io/docs/Builds/
# platformio run -e <variant> --target upload --upload-port <port>
# https://docs.platformio.org/en/latest/core/userguide/cmd_run.html#options

echo $device_port

# rsync -rv custom_builds/RC522/* "$dir_tasmota_source/tasmota/"

# append from $tasmota_build_custom_builds
[ ! -f "$dir_tasmota_source/tasmota/user_config_override.h" ] || rm "$dir_tasmota_source/tasmota/user_config_override.h"
for f in $tasmota_build_custom_builds; do (cat "custom_builds/${f}/user_config_override.h"; echo) >> "$dir_tasmota_source/tasmota/user_config_override.h"; done

echo project-dir="$dir_tasmota_source"

platformio run -e tasmota32 --target upload --upload-port "$device_port" --project-dir="$dir_tasmota_source"

./program.sh