#!/bin/bash

sudo add-apt-repository -y main
sudo add-apt-repository -y restricted
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt update

# https://wiki.ubuntuusers.de/Grafikkarten/Nvidia/nvidia/
sudo apt-get purge \*nvidia\* ; sudo apt-get install nvidia-driver-535 nvidia-settings # check if 535 should be updated

sudo dnf install -y ansible gh
sudo apt install -y ansible gh
sudo pamac install ansible gh
ansible-playbook -i hosts mysetup.playbook.yml

# JetBrains Toolbox
wget -cO jetbrains-toolbox.tar.gz "https://data.services.jetbrains.com/products/download?platform=linux&code=TBA"
tar -xzf jetbrains-toolbox.tar.gz
mkdir ~/Apps
cp jetbrains-toolbox-*/* ~/Apps
rm -r jetbrains-toolbox*
~/Apps/jetbrains-toolbox

# Clone all git repositories, https://stackoverflow.com/questions/19576742/how-to-clone-all-repos-at-once-from-github
gh auth login
gh repo list neonmika --limit 1000 | while read -r repo _; do
  gh repo clone $repo ~/Repos/$repo
done