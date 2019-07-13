#!/usr/bin/fish

# preparation
set hostusername xixiao
set username finxxi
set home_path /home/{$username}
set temp_path {$home_path}/temp
mkdir -p {$home_path}/temp
cd {$temp_path}

# brave browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
sudo apt update
sudo apt install brave-keyring brave-browser -y


# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /home/{$username}/.fzf
eval /home/{$username}/.fzf/install

# vm tools
sudo apt-get install open-vm-tools-desktop -y

# copy keys from host
# mkdir {$home_path}/Shared
# /usr/bin/vmhgfs-fuse -o auto_unmount .host:/ {$home_path}/Shared
# mkdir {$home_path}/.ssh
# cp {$home_path}/Shared/{$hostusername}/.ssh/id_rsa {$home_path}/.ssh/
# cp {$home_path}/Shared/{$hostusername}/.ssh/id_rsa.pub {$home_path}/.ssh/
# chmod og-rw {$home_path}/.ssh/id_rsa

# dotfiles
# echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> {$home_path}/.ssh/config
# git clone git@github.com:Xixiao007/dotfiles.git {$home_path}/dotfiles
# eval {$home_path}/dotfiles/bootstrap.sh -f

# font Consolas
sudo apt-get install font-manager -y
wget https://github.com/tsenart/sight/raw/master/fonts/Consolas.ttf
mkdir {$home_path}/.fonts
mv Consolas.ttf {$home_path}/.fonts
fc-cache -f -v

# enable new keybinding for fzf
#set -U FZF_LEGACY_KEYBINDINGS 0

# fish post_actions
fisher add jethrokuan/fzf
fisher add jethrokuan/z
fisher add jorgebucaran/fish-nvm
nvm use lts
npm install sfdx-cli --global

# update vmware-tools
git clone https://github.com/rasa/vmware-tools-patches.git
cd vmware-tools-patches
sudo ./patched-open-vm-tools.sh

# MANUAL STEP for java11
sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get update
# Manual download jdk11.tar from oracle site and 
# sudo cp jdk-11.0.3_linux-x64_bin.tar.gz /var/cache/oracle-jdk11-installer-local/
# sudo apt install oracle-java11-installer-local

# MANUAL STEP for dotfiles
cd {$home_path}
git clone https://github.com/Xixiao007/dotfiles.git
cd {$home_path}/dotfiles
# Manual run ./bootstrap.sh


cd {$home_path}
rm -Rf temp
#sudo reboot
