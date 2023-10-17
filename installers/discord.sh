#!/bin/bash
cd ~/Downloads
sudo rm -rf /opt/Discord/
wget -O discord.tar.gz "https://discord.com/api/download?platform=linux&format=tar.gz"
tar -xvf discord.tar.gz
sudo mv Discord /opt/ -v
sudo ln -svf /opt/Discord/Discord /usr/bin/discord