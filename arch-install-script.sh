#!/bin/bash

# Before running script, be sure base system is installed and bash is in chroot
# timedatectl set-ntp true
# lsblk - list available disks
# cfdisk /dev/sdX - partition selected disk
# mkfs.ext4 /dev/sdX1 - format partition
# mount /dev/sdX1 /mnt
# pacstrap /mnt base base-devel
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt

echo "Enter device's hostname:"
read -r hostname

echo "Enter disk path (/dev/sda)"
read -r d_path

ln -sf /usr/share/zoneinfo/Europe/Tallinn /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8\ UTF-8/en_US.UTF-8\ UTF-8/' /etc/locale.gen
sed -i 's/#et_EE.UTF-8\ UTF-8/et_EE.UTF-8\ UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "$hostname" > /etc/hostname

cat > /etc/hosts <<EOF
127.0.0.1 localhost
::1       localhost
127.0.1.1 $hostname.localdomain	$hostname
EOF

pacman -S --noconfirm grub bash-completion networkmanager

grub-install $d_path
grub-mkconfig -o /boot/grub/grub.cfg
