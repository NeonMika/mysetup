#!/bin/bash

# seems to not work on MX Linux
sudo add-apt-repository -y main
sudo add-apt-repository -y restricted
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt update

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

# https://wiki.ubuntuusers.de/Grafikkarten/Nvidia/nvidia/
# Function to check if a command is available and contains the specified string
check_command() {
    if command -v "$1" &> /dev/null; then
        echo "Checking with $1..."
        detection_output=$("$1")
        if [[ $detection_output == *"No NVIDIA GPU detected"* ]]; then
            echo "No NVIDIA card detected using $1."
        else
            echo "NVIDIA card detected using $1."
            return 0
        fi
    else
        echo "$1 is not installed on your system."
    fi
    return 1
}

# Flag to track whether an NVIDIA card is detected
nvidia_detected=0

# Check if either nvidia-detect or nvidia-detect-mx is available
check_command "nvidia-detect" && nvidia_detected=1
check_command "nvidia-detect-mx" && nvidia_detected=1

# Print the final message based on whether an NVIDIA card is detected
if [ $nvidia_detected -eq 1 ]; then
  echo "NVIDIA card detected."
  sudo apt-get purge \*nvidia\*
+ # Check if nvidia-driver-535 exists
  if apt-cache show nvidia-driver-535 &> /dev/null; then
    # return code was 0
    sudo apt install nvidia-driver-535
  else
    # return code was not 0
    echo "nvidia-driver-535 not found. Trying to install nvidia-driver"
    sudo apt install nvidia-driver
  fi
  sudo apt-get install nvidia-settings 
else
  echo "No NVIDIA card detected."
fi

# install all the stuff mentioned in README.md

# Communication
## Thunderbird
sudo apt install thunderbird

# Discord
sudo wget -cO /tmp/install-discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo chmod 0755 /tmp/install-discord.deb
sudo apt install /tmp/install-discord.deb
sudo rm /tmp/install-discord.deb


## Rambox
# sudo wget -cO /tmp/install-rambox.deb "https://rambox.app/api/download?os=linux&package=deb"
# sudo chmod 0755 /tmp/install-rambox.deb
# sudo apt install /tmp/install-rambox.deb
# sudo rm /tmp/install-rambox.deb

## Signal
sudo apt install signal-desktop

## Zoom
sudo wget -cO /tmp/install-zoom.deb "https://cdn.zoom.us/prod/5.16.10.668/zoom_amd64.deb"
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
sudo apt install gh

## Gitkraken
sudo wget -cO /tmp/install-gitkraken.deb "https://release.axocdn.com/linux/gitkraken-amd64.deb"
sudo chmod 0755 /tmp/install-gitkraken.deb
sudo apt install /tmp/install-gitkraken.deb
sudo rm /tmp/install-gitkraken.deb

## JetBrains Toolbox
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
mkdir ~/Apps
cp jetbrains-toolbox-*/* ~/Apps
rm -r jetbrains-toolbox*
~/Apps/jetbrains-toolbox

## nasm
sudo apt install nasm

## nvm
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
nvm install --lts

## openjdk-19-jdk
sudo apt install openjdk-19-jdk

## pv
sudo apt install pv

## python3
sudo apt install python3

## python3-pip
sudo apt install python3-pip

## python packages
sudo apt install python3-numpy python3-pandas python3-matplotlib

# VS code
sudo wget -cO /tmp/install-vscode.deb "https://vscode.download.prss.microsoft.com/dbazure/download/stable/af28b32d7e553898b2a91af498b1fb666fdebe0c/code_1.85.0-1701902998_amd64.deb"
sudo chmod 0755 /tmp/install-vscode.deb
sudo apt install /tmp/install-vscode.deb
sudo rm /tmp/install-vscode.deb


# Fundamentals

## ark
sudo apt install ark

## dropbox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
mkdir -p ~/Applications
sudo wget -cO ~/Applications/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod 0755 ~/Applications/dropbox.py
# ~/Applications/dropbox.py update
~/Applications/dropbox.py version
~/Applications/dropbox.py status
~/Applications/dropbox.py start
~/Applications/dropbox.py status

## firefox
sudo apt install firefox

## fzf
sudo apt install fzf

## stow
sudo apt install stow

## terminator
sudo apt install terminator

## vim
sudo apt install vim

## zsh
sudo apt install zsh

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
## obsidian
sudo wget -cO /tmp/install-obsidian.deb "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.4.16/obsidian_1.4.16_amd64.deb"
sudo chmod 0755 /tmp/install-obsidian.deb
sudo apt install /tmp/install-obsidian.deb
sudo rm /tmp/install-obsidian.deb

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
gh repo list ssw-jku --limit 1000 | while read -r repo _; do
  gh repo clone $repo ~/Repos/$repo
done
gh repo list neonmika --limit 1000 | while read -r repo _; do
  gh repo clone $repo ~/Repos/$repo
done

git clone https://ssw.jku.at/git/teaching/ub ~/Repos/ssw.jku.at/Compilerbau
git clone https://ssw.jku.at/git/research/eInformatics ~/Repos/ssw.jku.at/eInformatics
git clone http://ssw.jku.at/git/teaching/kotlin ~/Repos/ssw.jku.at/Kotlin
git clone ssh://teacher@poseidon.soft.uni-linz.ac.at:70/git/teaching ~/Repos/Pervasive/Teaching
