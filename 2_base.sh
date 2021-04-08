#!/bin/bash

# Detect username
username=$(whoami)

gpu_drivers="vulkan-intel lib32-vulkan-intel intel-media-driver libvdpau-va-gl nvidia"
libva_environment_variable="export LIBVA_DRIVER_NAME=iHD"
vdpau_environment_variable="export VDPAU_DRIVER=va_gl"

echo "Adding multilib support"
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

echo "Syncing repos and updating packages"
sudo pacman -Syu --noconfirm

echo "Installing and configuring UFW"
sudo pacman -S --noconfirm ufw
sudo systemctl enable ufw
sudo systemctl start ufw
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "Installing GPU drivers"
sudo pacman -S --noconfirm mesa lib32-mesa $gpu_drivers vulkan-icd-loader lib32-vulkan-icd-loader

echo "Adding Pacman Hook"
sudo touch /etc/pacman.d/hooks/nvidia.hook
sudo tee -a /etc/pacman.d/hooks/nvidia.hook << EOF	
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
 
[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF

echo "Blacklisting Noveau drivers"
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"

echo "Running System76 Installation"
chmod +x ezmode-gfx.sh
sh ./ezmode-gfx.sh

echo "Improving hardware video accelaration"
sudo pacman -S --noconfirm ffmpeg libva-utils libva-vdpau-driver vdpauinfo

echo "Installing common applications"
sudo pacman -S --noconfirm vi vim git openssh links upower htop powertop p7zip ripgrep unzip fwupd unrar

echo "Installing spacevim"
wget https://spacevim.org/install.sh
chmod +x install.sh
sh ./install.sh
cp .SpaceVim.d/init.toml ~/.SpaceVim.d/init.toml

echo "Adding Flathub repositories (Flatpak)"
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
flatpak update --appstream

#echo "Installing Flatpak GTK breeze themes"
#flatpak install --user --assumeyes flathub org.gtk.Gtk3theme.Breeze
#flatpak install --user --assumeyes flathub org.gtk.Gtk3theme.Breeze-Dark
#flatpak install --user --assumeyes flathub org.gtk.Gtk3theme.Adwaita
#flatpak install --user --assumeyes flathub org.gtk.Gtk3theme.Adwaita-dark

echo "Installing Firefox Flatpak"
flatpak install --user --assumeyes flathub org.mozilla.firefox

echo "Improving font rendering issues with Firefox Flatpak"
sudo pacman -S --noconfirm gnome-settings-daemon
mkdir -p ~/.var/app/org.mozilla.firefox/config/fontconfig	
touch ~/.var/app/org.mozilla.firefox/config/fontconfig/fonts.conf	
tee -a ~/.var/app/org.mozilla.firefox/config/fontconfig/fonts.conf << EOF	
<?xml version='1.0'?>	
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>	
<fontconfig>	
    <!-- Disable bitmap fonts. -->	
    <selectfont><rejectfont><pattern>	
        <patelt name="scalable"><bool>false</bool></patelt>	
    </pattern></rejectfont></selectfont>	
</fontconfig>	
EOF

echo "Installing Chrome Flatpak with GPU acceleration"
flatpak install --user --assumeyes flathub-beta com.google.Chrome
mkdir -p ~/.var/app/com.google.Chrome/config
touch ~/.var/app/com.google.Chrome/config/chrome-flags.conf
tee -a ~/.var/app/com.google.Chrome/config/chrome-flags.conf << EOF
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-zero-copy
--enable-accelerated-video-decode
--use-vulkan
--password-store=basic
EOF

echo "Installing Chromium Flatpak with GPU acceleration"
flatpak install --user --assumeyes flathub org.chromium.Chromium
mkdir -p ~/.var/app/org.chromium.Chromium/config
touch ~/.var/app/org.chromium.Chromium/config/chromium-flags.conf
tee -a ~/.var/app/org.chromium.Chromium/config/chromium-flags.conf << EOF
--ignore-gpu-blacklist
--enable-gpu-rasterization
--enable-zero-copy
--enable-accelerated-video-decode
--use-vulkan
EOF

echo "Creating user's folders"
sudo pacman -S --noconfirm xdg-user-dirs

echo "Set environment variables and alias"
touch ~/.zshrc
tee -a ~/.zshrc << EOF
alias upa="sudo rm -f /var/lib/pacman/db.lck && sudo pacman -Syu && yay -Syu --aur && flatpak update && fwupdmgr refresh && fwupdmgr update"
export TERM=xterm
EOF

echo "Installing yay"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --noconfirm
cd ..
rm -rf yay-bin

echo "Installing and configuring Plymouth"
yay -S --noconfirm plymouth-git
sudo sed -i 's/base systemd autodetect/base systemd sd-plymouth autodetect/g' /etc/mkinitcpio.conf
sudo sed -i 's/quiet rw/quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0 rw/g' /boot/loader/entries/arch.conf
sudo sed -i 's/quiet rw/quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0 rw/g' /boot/loader/entries/arch-lts.conf
sudo mkinitcpio -p linux
sudo mkinitcpio -p linux-lts
sudo plymouth-set-default-theme -R bgrt

echo "Installing and starting thermald"
sudo pacman -S --noconfirm thermald
sudo systemctl start thermald.service
sudo systemctl enable thermald.service

if [[ $(cat /sys/class/dmi/id/chassis_type) -eq 10 ]]
then
echo "Improving laptop battery"
echo "Enabling audio power saving features"
sudo touch /etc/modprobe.d/audio_powersave.conf
sudo tee -a /etc/modprobe.d/audio_powersave.conf << EOF
options snd_hda_intel power_save=1
EOF

echo "Enabling wifi (iwlwifi) power saving features"
sudo touch /etc/modprobe.d/iwlwifi.conf
sudo tee -a /etc/modprobe.d/iwlwifi.conf << EOF
options iwlwifi power_save=1
EOF

echo "Installing Audio"
pacman -S --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth

echo "Reducing VM writeback time"
sudo touch /etc/sysctl.d/dirty.conf
sudo tee -a /etc/sysctl.d/dirty.conf << EOF
vm.dirty_writeback_centisecs = 1500
EOF
fi

echo "Setting environment variables (and improve Java applications font rendering)"
sudo tee -a /etc/environment << EOF
$libva_environment_variable
$vdpau_environment_variable
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
export JAVA_FONTS=/usr/share/fonts/TTF
EOF

echo "Enabling bluetooth"
sudo systemctl start bluetooth.service
sudo systemctl enable bluetooth.service

echo "Disabling root (still allows sudo)"
passwd --lock root

echo "Adding NTFS support"
sudo pacman -S --noconfirm ntfs-3g

echo "Installing Spotify / KeepassXC / LibreOffice Flatpaks"
flatpak install --user --assumeyes flathub com.spotify.Client
flatpak install --user --assumeyes flathub org.keepassxc.KeePassXC
flatpak install --user --assumeyes flathub org.libreoffice.LibreOffice

echo "Installing Docker"
tee /etc/modules-load.d/loop.conf <<< "loop"
modprobe loop
pacman -S docker 
systemctl start docker.service
systemctl enable docker.service
groupadd docker
gpasswd -a user docker $USER

# Ones we might want to maintain
echo "Installing programs from pkglist_pacman.txt"
pacman -S $(cat pkglist_pacman.txt)

# Extra apps
echo "Installing programs from pkglist_yay.txt"
yay -S $(cat pkglist_yay.txt")