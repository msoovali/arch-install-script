#!/bin/bash

genfstab -U /mnt >> /mnt/etc/fstab

echo Enter device's hostname:
read $hostname

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Tallinn /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8' /etc/locale.gen
sed -i 's/#et_EE.UTF-8 UTF-8/et_EE.UTF-8 UTF-8' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo $hostname > /etc/hostname

echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		$hostname.localdomain	$hostname" >> /etc/hosts

pacman -S grub bash-completion networkmanager

echo "Enable grub by executing 
grub-install /dev/sdX1 
and 
grub-mkconfig -o /boot/grub/grub.cfg
then exit and reboot"
