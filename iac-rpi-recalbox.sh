#!/bin/sh
###################################################################
#  Script Name  :  insert a coin recalbox install script
#  Description  :  install everything you need to use the 
#                  insertaco.in rpi interface.
#  Author       :  Alexandre Ribeiro de Sá
#  Site         :  http://insertaco.in
###################################################################
#  LOG
#  2019/04/29 @alexribeirodesa
#             file created

# mount boot partition
echo "PARTITION REMOUNT"
mount -o remount, rw /boot
mount -o remount, rw /

# download iacvga
echo "INSTALLING INSERTACO.IN VGA OUTPUT"
#download
wget -P /boot/overlays/ https://github.com/insertacoin/iac_overlays/raw/master/bin/iacvga-overlay.dtbo

# download iacgamepad
echo "INSTALLING INSERTACO.IN GAMEPAD"
## update and install wiringpi
wget -P /usr/lib/ https://github.com/insertacoin/iac_joystick/raw/master/bin/libwiringPi.so

## download 
wget -P /bin/ https://github.com/insertacoin/iac_joystick/raw/master/bin/iacgamepad
chmod a+x /bin/iacgamepad
wget -P /etc/init.d/ https://github.com/insertacoin/iac_joystick/raw/master/service/S99iacgamepad.sh
chmod a+x /etc/init.d/S99iacgamepad.sh

## include /boot/config.txt stuff
echo "INCLUDING /boot/config.txt SETTINGS"
echo " " >> /boot/config.txt
echo " " >> /boot/config.txt
echo " " >> /boot/config.txt
echo " " >> /boot/config.txt
echo " " >> /boot/config.txt
echo "# /boot/config.txt" >> /boot/config.txt
echo "## INSERT A COIN" >> /boot/config.txt
echo "# Disable IIC and SPI to use VGA output" >> /boot/config.txt
echo "dtparam=i2c_arm=off" >> /boot/config.txt
echo "dtparam=spi=off" >> /boot/config.txt
echo " " >> /boot/config.txt
echo "# Enable audio output" >> /boot/config.txt
echo "dtparam=audio=on" >> /boot/config.txt
echo "disable_audio_dither=1" >> /boot/config.txt
echo "audio_pwm_mode=2" >> /boot/config.txt
echo "dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2" >> /boot/config.txt
echo "hdmi_force_hotplug=1" >> /boot/config.txt
echo " " >> /boot/config.txt
echo "# Enable the VGA output" >> /boot/config.txt
echo "#dtoverlay=iacvga-overlay" >> /boot/config.txt
echo "#enable_dpi_lcd=1" >> /boot/config.txt
echo "#dpi_output_format=6" >> /boot/config.txt
echo "#display_default_lcd=1" >> /boot/config.txt
echo "#dpi_group=2            # set screen resolution to 800x600" >> /boot/config.txt
echo "#dpi_mode=9" >> /boot/config.txt
echo " " >> /boot/config.txt
echo "# Disable false warning by power supply noise issue" >> /boot/config.txt
echo "# solved in revision 2" >> /boot/config.txt
echo "avoid_warnings=2" >> /boot/config.txt

## reboot
echo "READY TO REBOOT!"
sleep 5
reboot -f
