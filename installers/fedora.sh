#!/bin/bash
# Configure system
echo "Configuring bash, dnf, and git."

## Configure git
git config --global user.name "Luke-Oldenburg"
git config --global user.email "87272260+Luke-Oldenburg@users.noreply.github.com"

## Autocomplete ignore case
sudo sh -c "echo \"bind 'set completion-ignore-case on'\" >> /etc/bashrc"

## Configure dnf
sudo sh -c "echo \"defaultyes=True\" >> /etc/dnf/dnf.conf"
sudo sh -c "echo \"max_parallel_downloads=20\" >> /etc/dnf/dnf.conf"

# Install shortcuts
echo "Installing shortcuts."
sudo cp -r ../shortcuts/* /usr/share/applications/

# Install dnf packages
echo "Installing dnf packages."
sudo dnf check-update -y
sudo dnf install akmod-nvidia alien audacity cargo dconf-editor deja-dup ffmpeg-free gcc gcc-c++ gimp gnome-extensions-app gnome-tweaks htop java-17-openjdk-* mpv ncdu neofetch nmap nodejs nvtop obs-studio rust steam yt-dlp -y

## Multimedia codecs
echo "Installing multimedia codecs."
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

cd ~/Downloads

# GNOME Extensions
echo "Installing GNOME Extensions."
echo "Installing GNOME Extensions avaliable via dnf."
sudo dnf install gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock gnome-shell-extension-openweather -y

## Alphabetical App Grid
echo "Installing Alphabetical App Grid."
wget -O alphabetical_app_grid.zip https://extensions.gnome.org/extension-data/AlphabeticalAppGridstuarthayhurst.v31.shell-extension.zip
alphabetical_app_grid=$(unzip -c alphabetical_app_grid.zip metadata.json | grep uuid | cut -d \" -f4)
mkdir -p ~/.local/share/gnome-shell/extensions/$alphabetical_app_grid
unzip -q alphabetical_app_grid.zip -d ~/.local/share/gnome-shell/extensions/$alphabetical_app_grid
gnome-extensions enable $alphabetical_app_grid

## Extension List
echo "Installing Extension List."
wget -O extension_list.zip https://extensions.gnome.org/extension-data/extension-listtu.berry.v35.shell-extension.zip
extension_list=$(unzip -c extension_list.zip metadata.json | grep uuid | cut -d \" -f4)
mkdir -p ~/.local/share/gnome-shell/extensions/$extension_list
unzip -q extension_list.zip -d ~/.local/share/gnome-shell/extensions/$extension_list
gnome-extensions enable $extension_list

## Vitals
echo "Installing Vitals."
wget -O vitals.zip https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v61.shell-extension.zip
vitals=$(unzip -c vitals.zip metadata.json | grep uuid | cut -d \" -f4)
mkdir -p ~/.local/share/gnome-shell/extensions/$vitals
unzip -q vitals.zip -d ~/.local/share/gnome-shell/extensions/$vitals
gnome-extensions enable $vitals

# RPMs
echo "Installing RPMs."
## Bitwarden
echo "Installing Bitwarden."
wget -O bitwarden.rpm "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm"
sudo rpm -i bitwarden.rpm

## ProtonVPN
echo "Installing ProtonVPN."
wget -O protonvpn.rpm https://repo.protonvpn.com/fedora-38-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.1-2.noarch.rpm
sudo rpm -i protonvpn.rpm
sudo dnf check-update -y
sudo dnf install libappindicator-gtk3 protonvpn python3-pip -y
pip3 install --user 'dnspython>=1.16.0'

## VSCode
echo "Installing VSCode."
wget -O vscode.rpm "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"
sudo rpm -i vscode.rpm

# Tarballs
echo "Installing tarballs."
## Install Discord
echo "Installing Discord."
wget -O discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
tar -xvf discord.tar.gz
sudo mv Discord /opt/
sudo ln -svf /opt/Discord/Discord /usr/bin/discord

## Install IntelliJ IDEA Ultimate
echo "Installing IntelliJ IDEA Ultimate."
wget -O idea.tar.gz https://download.jetbrains.com/idea/ideaIU-2023.2.tar.gz
tar -xvf idea.tar.gz
sudo mkdir /opt/idea/
sudo chmod 777 /opt/idea/
sudo mv idea-*/* /opt/idea/
sudo ln -svf /opt/idea/bin/idea.sh /usr/bin/intellij-idea-ultimate

# Install Minecraft
echo "Installing Minecraft."
wget -O minecraft.tar.gz https://launcher.mojang.com/download/Minecraft.tar.gz
tar -xvf minecraft.tar.gz
sudo mv minecraft-launcher /opt/
sudo ln -svf /opt/minecraft-launcher/minecraft-launcher /usr/bin/minecraft

# Install Postman
echo "Installing Postman."
wget -O postman.tar.gz https://dl.pstmn.io/download/latest/linux_64
tar -xvf postman.tar.gz
sudo mv Postman /opt/
sudo ln -svf /opt/Postman/Postman /usr/bin/postman

sudo dnf upgrade -y && sudo dnf autoremove -y
read -rsp $'Press any key to continue...\n' -n 1 key

# Reboot
for i in {5..1}
do
  echo -e "\e[41mWARNING: Rebooting in $i seconds! Press CTRL + C to cancel.\e[0m"
  sleep 1s
done
reboot