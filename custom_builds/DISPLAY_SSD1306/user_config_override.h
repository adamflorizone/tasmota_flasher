#define USE_I2C
  #define USE_DISPLAY
    #define USE_DISPLAY_SSD1306
  // #define SHOW_SPLASH
  #define USE_RAMFONT
  #define USE_AWATCH
  // #define USE_GRAPH

/*
Detect PNP:
Display
i2cdriver
i2cscan

Shows time:
DisplayMode  1

// https://tasmota.github.io/docs/Displays/
// https://tasmota.github.io/docs/Rules/

sudo mosquitto_passwd -b /var/snap/mosquitto/common/password_file DVES_USER 'cP3453FPf4kd'
sudo chmod 600 /var/snap/mosquitto/common/password_file
sudo chown root:root /var/snap/mosquitto/common/password_file
sudo snap restart mosquitto

cp /var/snap/mosquitto/common/mosquitto_example.conf /var/snap/mosquitto/common/mosquitto.conf 

// Paths per snap: https://snapcraft.io/mosquitto
// https://mosquitto.org/documentation/authentication-methods/
sudo sh -c "cat >/var/snap/mosquitto/common/mosquitto.conf" <<-EOF
#persistence false
#user root
#per_listener_settings false
listener 1983
password_file /var/snap/mosquitto/common/password_file
allow_anonymous false
EOF

sudo snap restart mosquitto

publish test/topic {"From":"%Var1%","To":"%Var2%"}
or
watch "date | xargs -I{} mosquitto_pub -p 1983 -u DVES_USER -P 'cP3453FPf4kd' -t 'test/topic' -m '{}'"

mosquitto_sub -p 1983 -u DVES_USER -P 'cP3453FPf4kd' -t 'test/topic' -v

*/