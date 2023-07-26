#!/bin/bash

sudo add-apt-repository -y main
sudo add-apt-repository -y restricted
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt update

# https://wiki.ubuntuusers.de/Grafikkarten/Nvidia/nvidia/
sudo apt-get purge \*nvidia\* ; sudo apt-get install nvidia-driver-535 nvidia-settings # check if 535 should be updated

# install all the stuff mentioned in README.md

# Communication
## Thunderbird
sudo apt install thunderbird

## Rambox
sudo wget -cO /tmp/install-rambox.deb "https://rambox.app/api/download?os=linux&package=deb"
sudo chmod 0755 /tmp/install-rambox.deb
sudo apt install /tmp/install-rambox.deb
sudo rm /tmp/install-rambox.deb

## Signal
sudo apt install signal-desktop

## Zoom
sudo wget -cO /tmp/install-zoom.deb "https://zoom.us/client/5.12.6.173/zoom_amd64.deb"
sudo chmod 0755 /tmp/install-zoom.deb
sudo apt install /tmp/install-zoom.deb
sudo rm /tmp/install-zoom.deb

# Connection

## bluez
sudo apt install bluez

## blueman
sudo apt install blueman

# Development

## cmake
sudo apt install cmake

## gh

## JetBrains Toolbox
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
mkdir ~/Apps
cp jetbrains-toolbox-*/* ~/Apps
rm -r jetbrains-toolbox*
~/Apps/jetbrains-toolbox

## nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

## openjdk-19-jdk
sudo apt install openjdk-19-jdk

## pv
sudo apt install pv

## nasm
sudo apt install nasm

## python3
sudo apt install python3

## python3-pip
sudo apt install python3-pip

# Fundamentals

## zsh
sudo apt install zsh

## vim
sudo apt install vim

## terminator
sudo apt install terminator

## ark
sudo apt install ark

## fzf
sudo apt install fzf

## firefox
sudo apt install firefox

## stow
sudo apt install stow

# Gaming

## heroic
sudo apt install heroic

## lutris
sudo apt install lutris

## mangohud
sudo apt install mangohud

## steam
sudo apt install steam

# Office

## gedit
sudo apt install gedit
## gedit-plugins
sudo apt install gedit-plugins
## okular
sudo apt install okular
## xournal
sudo apt install xournal
## xournal+
sudo apt install xournalpp

# Security

## keepassxc
sudo apt install keepassxc

# Clone all git repositories, https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github
gh auth login
gh repo list neonmika --limit 1000 | while read -r repo _; do
  gh repo clone $repo ~/Repos/$repo
done
