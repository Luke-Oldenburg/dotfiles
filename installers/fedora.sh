#!/bin/bash

# Configure git
echo "Configuring git."
git config --global user.name "Luke Oldenburg"
git config --global user.email "87272260+Luke-Oldenburg@users.noreply.github.com"
git config --global alias.forcepull '!git fetch --all && git reset --hard origin/$(git symbolic-ref --short HEAD)'

# Configure bash
echo "Configuring bash."
echo "bind 'set completion-ignore-case on'" | sudo tee -a /etc/bashrc
echo "alias codehere=\"code . &\"" | sudo tee -a /etc/bashrc

# Configure dnf
echo "Configuring dnf."
echo "defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
echo "max_parallel_downloads=20" | sudo tee -a /etc/dnf/dnf.conf
echo "deltarpm=True" | sudo tee -a /etc/dnf/dnf.conf

# Configure swap
echo "Configuring swap."
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf
sudo sysctl --load

# Configure gnome
echo "Configuring gnome."
gsettings set org.gnome.mutter check-alive-timeout 0

# Add shortcuts
echo "Adding shortcuts."
sudo cp -r ../shortcuts/* /usr/share/applications/ -v

# Remove unwanted 3rd party repositories
echo "Removing unwanted 3rd party repositories."
sudo rm -f /etc/yum.repos.d/google-chrome.repo -v
sudo rm -f /etc/yum.repos.d/_copr\:copr.fedorainfracloud.org\:phracek\:PyCharm.repo -v

# Install dnf packages
echo "Installing dnf packages."
dnf check-update
sudo dnf install 2048-cli alien audacity blender chromium cowsay dconf-editor deja-dup fastfetch ffmpeg-free gcc gcc-c++ gh.x86_64 ghex gimp gnome-extensions-app gnome-firmware gnome-tweaks godot golang htop inkscape java-21-openjdk* kicad mpv ncdu nmap nodejs obs-studio redis rust seahorse steam tailscale thefuck wget2-wget xkill yt-dlp -y
sudo ln -svf /usr/bin/fastfetch /usr/bin/fetch

# Configure thefuck
echo "eval \"\$(thefuck --alias)\"" | sudo tee -a /etc/bashrc
source /etc/bashrc
fuck -a frick

## Multimedia codecs
echo "Installing multimedia codecs."
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing

# Install flatpaks
echo "Installing flatpaks."
flatpak install com.bitwarden.desktop -yv
flatpak install com.discordapp.Discord -yv
flatpak install com.getpostman.Postman -yv
flatpak install com.google.AndroidStudio -yv
flatpak install com.jetbrains.IntelliJ-IDEA-Ultimate -yv
flatpak install com.protonvpn.www -yv
flatpak install com.slack.Slack -yv
flatpak install org.onlyoffice.desktopeditors -yv
flatpak install org.signal.Signal -yv

# Misc install scripts
cd ~/Downloads
## Install chirp
sudo dnf install python3-wxpython4 pipx
wget -O chirp.whl https://archive.chirpmyradio.com/chirp_next/next-20240706/chirp-20240706-py3-none-any.whl
pipx install --system-site-packages ./chirp.whl

## Install Minecraft
echo "Installing Minecraft."
wget -O minecraft.tar.gz https://launcher.mojang.com/download/Minecraft.tar.gz
tar -xvf minecraft.tar.gz
sudo mv minecraft-launcher /opt/ -v
cd -
sudo mv ../assets/minecraft256.png /opt/minecraft-launcher/ -v
cd ~/Downloads
sudo ln -svf /opt/minecraft-launcher/minecraft-launcher /usr/bin/minecraft-launcher

## VSCode
echo "Installing VSCode."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -v
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code -y

# Update dnf
echo "Updating dnf."
sudo dnf upgrade -y && sudo dnf autoremove -y

# GNOME Extensions
echo "Install these GNOME Extensions manually:"
echo "Alphabetical App Grid:    https://extensions.gnome.org/extension/4269/alphabetical-app-grid/"
echo "AppIndicator:             https://extensions.gnome.org/extension/615/appindicator-support/"
echo "Caffeine:                 https://extensions.gnome.org/extension/517/caffeine/"
echo "Clipboard Indicator:      https://extensions.gnome.org/extension/779/clipboard-indicator/"
echo "Dash to Dock:             https://extensions.gnome.org/extension/307/dash-to-dock/"
echo "Extension List:           https://extensions.gnome.org/extension/3088/extension-list/"
echo "Tiling Shell:             https://extensions.gnome.org/extension/7065/tiling-shell/"
echo "Vitals:                   https://extensions.gnome.org/extension/1460/vitals/"

echo "Make sure to modify grub config."
echo "Remove:    \"quiet\""
echo "Add:       \"thunderbolt.host_reset=false\""
echo "Run:       \"sudo grub2-mkconfig && sudo grub2-mkconfig -o /boot/grub2/grub.cfg\""

read -rsp $'Press any key to continue...\n' -n 1 key

# Reboot
for i in {5..1}
do
  echo -e "\e[41mWARNING: Rebooting in $i seconds! Press CTRL + C to cancel.\e[0m"
  sleep 1s
done
reboot