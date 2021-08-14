source ./tasmota_flasher.config

if [ "$device_write_config" = true ]; then
    Backlog="";

    [ -z "$device_config_ssid1" ] || Backlog+="SSID1 $device_config_ssid1; "
    [ -z "$device_config_password1" ] || Backlog+="Password1 $device_config_password1; "
    [ -z "$device_config_ssid2" ] || Backlog+="SSID2 $device_config_ssid2; "
    [ -z "$device_config_password2" ] || Backlog+="Password2 $device_config_password2; "

    [ -z "$Backlog" ] || Backlog+="Status 4"

    if [ ! -z "$Backlog" ]; then
        stty 115200 -F "$device_port"
        exec 3<> "$device_port"
        
        echo "Wating for boot (5 sec)..."
        sleep 5


        echo "Sending wifi auth details..."
        echo "Backlog $Backlog" >&3
        sleep 1

  
        cat <&3
        sleep 5
        exec 3>&-
    fi
    #Backlog MqttHost <yourhost>; MqttUser <user>; MqttPassword <password>; Topic <customtopic>; SetOption53 1; PowerRetain on
fi