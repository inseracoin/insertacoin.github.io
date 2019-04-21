#!/bin/sh
###################################################################
#  Script Name  :  insert a coin install script                                                                                             
#  Description  :  install everything you need to use the 
#                  insertaco.in rpi controller.
#  Author       :  Alexandre Ribeiro de Sá
#  Site         :  insertaco.in
###################################################################
#  LOG
#  2019/04/17 @alexribeirodesa
#             file created

# download iacvga
echo "INSTALLING INSERTACO.IN VGA OUTPUT"
#download
sudo wget -P /boot/overlays/ https://github.com/insertacoin/iac_overlays/raw/master/bin/iacvga-overlay.dtbo

# download iacgamepad
echo "INSTALLING INSERTACO.IN GAMEPAD"
## update and install wiringpi
sudo apt-get update
sudo apt-get -y install wiringpi

## download 
sudo wget -P /bin/ https://github.com/insertacoin/iac_joystick/raw/master/bin/iacgamepad
sudo chmod a+x /bin/iacgamepad

sudo wget -P /etc/systemd/system/ https://github.com/insertacoin/iac_joystick/raw/master/service/iacgamepad.service

## service start
sudo systemctl daemon-reload
sleep 2
sudo systemctl enable iacgamepad
sleep 2
sudo systemctl start iacgamepad
sleep 2

## include /boot/config.txt stuff
echo "INCLUDING /boot/config.txt SETTINGS"
sudo echo " " >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo "# /boot/config.txt" >> /boot/config.txt
sudo echo "## INSERT A COIN" >> /boot/config.txt
sudo echo "# Disable IIC and SPI to use VGA output" >> /boot/config.txt
sudo echo "dtparam=i2c_arm=off" >> /boot/config.txt
sudo echo "dtparam=spi=off" >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo "# Enable audio output" >> /boot/config.txt
sudo echo "dtparam=audio=on" >> /boot/config.txt
sudo echo "disable_audio_dither=1" >> /boot/config.txt
sudo echo "audio_pwm_mode=2" >> /boot/config.txt
sudo echo "dtoverlay=pwm-2chan,pin=18,func=2,pin2=19,func2=2" >> /boot/config.txt
sudo echo "hdmi_force_hotplug=1" >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo "# Enable the VGA output" >> /boot/config.txt
sudo echo "#dtoverlay=iacvga-overlay" >> /boot/config.txt
sudo echo "#enable_dpi_lcd=1" >> /boot/config.txt
sudo echo "#dpi_output_format=6" >> /boot/config.txt
sudo echo "#display_default_lcd=1" >> /boot/config.txt
sudo echo "#dpi_group=2            # set screen resolution to 800x600" >> /boot/config.txt
sudo echo "#dpi_mode=9" >> /boot/config.txt
sudo echo " " >> /boot/config.txt
sudo echo "# Disable false warning by power supply noise issue" >> /boot/config.txt
sudo echo "# solved in revision 2" >> /boot/config.txt
sudo echo "avoid_warnings=2" >> /boot/config.txt

## set the audio output
echo "SETTING AUDIO OUTPUT"
amixer cset numid=3 1

## reboot
echo "READY TO REBOOT!"
sleep 5
sudo reboot now




