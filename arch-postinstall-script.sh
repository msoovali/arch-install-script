#!/bin/bash


# X server + drivers
sudo pacman -S xorg-server xorg-apps xorg-xinit xf86-video-intel xf86-video-nouveau --noconfirm --needed
# Display manager with gtk frontend and enable in systemd
sudo pacman -S lightdm lightdm-gtk-greeter --noconfirm --needed
sudo systemctl enable lightdm.service
# graphical indicator for networkmanager
sudo pacman -S network-manager-applet --noconfirm --needed
# mate desktop environment
sudo pacman -S mate mate-extra --noconfirm --needed
# printing service
sudo pacman -S cups cups-pdf system-config-printer --noconfirm --needed
sudo systemctl enable org.cups.cupsd.service
# some fonts
sudo pacman -S adobe-source-sans-pro-fonts cantarell-fonts noto-fonts terminus-font ttf-bitstream-vera ttf-dejavu ttf-droid ttf-inconsolata ttf-liberation ttf-roboto ttf-ubuntu-font-family tamsyn-font --noconfirm --needed
# some useful applications
sudo pacman -S firefox gimp audacity transmission-gtk vlc --noconfirm --needed
# wireless driver
sudo pacman -S broadcom-wl --noconfirm --needed
# themes
sudo pacman -S arc-gtk-theme papirus-icon-theme --noconfirm --needed
# audio
sudo pacman -S pulseaudio pulseaudio-alsa --noconfirm --needed
# qt applications
sudo pacman -S kio --noconfirm --needed
