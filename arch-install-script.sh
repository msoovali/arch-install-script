#!/bin/bash

# Before running script, be sure base system is installed and bash is in chroot
# timedatectl set-ntp true
# lsblk - list available disks
# cfdisk /dev/sdX - partition selected disk
#
# -- DOS --
# mkfs.ext4 /dev/sdX1 - format partition
# mount /dev/sdX1 /mnt
# -- GPT --
# mkfs.ext4 /dev/sda2
# mkfs.vfat /dev/sda1
# mount /dev/sda2 /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot
#
# pacstrap /mnt base base-devel linux linux-firmware nano networkmanager bash-completion intel-ucode
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt

echo "Enter device's hostname:"
read -r hostname

# echo "Enter disk path (/dev/sda)" <-- DOS
echo "Enter Linux filesystem path (/dev/sda2)"
read -r d_path

ln -sf /usr/share/zoneinfo/Europe/Tallinn /etc/localtime
hwclock --systohc

sed -i 's/#en_US.UTF-8\ UTF-8/en_US.UTF-8\ UTF-8/' /etc/locale.gen
sed -i 's/#et_EE.UTF-8\ UTF-8/et_EE.UTF-8\ UTF-8/' /etc/locale.gen
locale-gen

cp ./resources/locale.conf /etc/

echo "$hostname" > /etc/hostname

cat > /etc/hosts <<EOF
127.0.0.1 localhost
::1       localhost
127.0.1.1 $hostname.localdomain	$hostname
EOF

# DOS
#pacman -S --noconfirm grub
#grub-install $d_path
#grub-mkconfig -o /boot/grub/grub.cfg

# GPT
bootctl --path=/boot install
cp ./resources/loader.conf /boot/loader/
cp ./resources/arch.conf /boot/loader/entries/
uuid_of_partition=$(blkid $d_path -o value UUID)
sed -i "s/MY_UUID/$uuid_of_partition/" /boot/loader/entries/arch.conf

