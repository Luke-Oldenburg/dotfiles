#!/bin/bash
# Install apt packages
echo "Installing apt packages."
sudo apt update
sudo apt install audacity curl dconf-editor deja-dup epiphany-browser ffmpeg g++ gcc gimp git gnome-tweaks htop mlocate mpv ncdu neofetch net-tools nmap nvtop obs-studio openjdk-17-* python3 python3-pip rpi-imager steam tmux tree ubuntu-restricted-extras vim vlc wget yt-dlp -y

# Install virtulization software
echo "Installing virtualization software."
sudo apt install bridge-utils libvirt-clients libvirt-daemon libvirt-daemon-system qemu-kvm virt-manager virt-viewer virtinst -y

# Other installers
echo "Running other installers."
bash firefox.sh
bash signal.sh

# Install snap packages
echo "Installing snap packages."
sudo snap install bitwarden
sudo snap install code --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install node --classic
sudo snap install onlyoffice-desktopeditors
sudo snap install postman
sudo snap install spotify

# Install flutter
echo "Installing flutter."
sudo snap install flutter --classic
flutter upgrade --force
echo "Installing dependencies for linux desktop support in flutter."
sudo apt install clang cmake libgtk-3-dev ninja-build pkg-config -y
dart --disable-analytics
flutter config --no-analytics
flutter config --enable-linux-desktop
flutter config --enable-macos-desktop
flutter config --enable-windows-desktop

# Configure git
echo "Configuring git."
git config --global user.name "Luke-Oldenburg"
git config --global user.email "87272260+Luke-Oldenburg@users.noreply.github.com"

# Upgrade packages
echo "Upgrading packages"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
sudo snap refresh

# Non-automated installs
echo "Manually install these programs:"
echo "Discord:      https://discord.com/"
echo "Docker:       https://docs.docker.com/engine/install/ubuntu/"
echo "Firefox:      https://launchpad.net/~mozillateam/+archive/ubuntu/ppa"
echo "Minecraft:    https://www.minecraft.net/en-us/download"
echo "ProtonVPN:    https://protonvpn.com/support/linux-ubuntu-vpn-setup/"

read -rsp $'Press any key to continue...\n' -n 1 key

# Reboot
for i in {5..1}
do
  echo -e "\e[41mWARNING: Rebooting in $i seconds! Press CTRL + C to cancel.\e[0m"
  sleep 1s
done
reboot