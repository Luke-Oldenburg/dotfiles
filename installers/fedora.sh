#!/bin/bash
# Configure system
echo "Configuring system."
git config --global user.name "Luke-Oldenburg"
git config --global user.email "87272260+Luke-Oldenburg@users.noreply.github.com"
echo "bind 'set completion-ignore-case on'" >> ~/.bashrc
sudo sh -c "echo \"defaultyes=True\" >> /etc/dnf/dnf.conf"
sudo sh -c "echo \"max_parallel_downloads=10\" >> /etc/dnf/dnf.conf"
sudo cp -r ../shortcuts/* /usr/share/applications/

# Install dnf packages
echo "Installing dnf packages."
sudo dnf update -y
sudo dnf install akmod-nvidia alien audacity dconf-editor deja-dup ffmpeg-free gcc gcc-c++ gimp gnome-extensions-app gnome-shell-extension-appindicator gnome-shell-extension-caffeine gnome-shell-extension-dash-to-dock gnome-tweaks htop java-17-openjdk-* mpv ncdu neofetch nmap nodejs nvtop obs-studio steam yt-dlp -y
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

# Non-automated installs
echo "Manually install these programs:"
echo "Bitwarden:    https://bitwarden.com/download/"
echo "Clipboard:    https://extensions.gnome.org/extension/779/clipboard-indicator/"
echo "Discord:      https://discord.com"
echo "IntelliJ:     https://www.jetbrains.com/idea/download/?section=linux"
echo "Minecraft:    https://www.minecraft.net/en-us/download"
echo "Postman:      https://www.postman.com/downloads/"
echo "ProtonVPN:    https://protonvpn.com/support/official-linux-vpn-fedora/"
echo "Vitals:       https://extensions.gnome.org/extension/1460/vitals/"
echo "VS Code:      https://code.visualstudio.com/Download"

read -rsp $'Press any key to continue...\n' -n 1 key

# Reboot
for i in {5..1}
do
  echo -e "\e[41mWARNING: Rebooting in $i seconds! Press CTRL + C to cancel.\e[0m"
  sleep 1s
done
reboot