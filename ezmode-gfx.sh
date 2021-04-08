#!/bin/bash
# Shout outs to: https://archie9211.github.io/blog/guide-for-complete-nvidia-and-tensorflow-setup-on-arch-linux-using-system76-drvers-on-any-non-system76-device

# This needs to be ran as sudo:
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Please run this as script as a sudo user!"
    exit
fi

# Install System76-power/dkms and enable it.
yay -S system76-power system76-dkms
systemctl enable system76-power.service

#System76 Drivers require “ec_sys.write_support=1” argument to be passed for kernel to work.
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& ec_sys.write_support=1/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Install Bumblee and Optimus
pacman -S bumblebee primus 
gpasswd -a $USER bumblebee
systemctl enable bumblebeed.service 
pacman -S nvidia-dkms nvidia-settings

echo -e '\n' >> /home/netyaroze/.zshrc
echo '#system76 switch settings' >> /home/netyaroze/.zshrc
echo 'alias nvidia-settings="optirun -b none nvidia-settings -c :8 "' >> /home/netyaroze/.zshrc
echo 'alias nvidia-on="sudo system76-power graphics power on ; sudo modprobe nvidia-drm nvidia-modeset nvidia"' >> /home/netyaroze/.zshrc  
echo 'alias nvidia-off="sudo rmmod nvidia-drm nvidia-modeset nvidia ; sudo system76-power graphics power off"' >> /home/netyaroze/.zshrc 
echo 'alias nvidia-working="primusrun glxinfo | grep -i renderer"' >> /home/netyaroze/.zshrc

echo "REBOOT YOUR SYSTEM"
