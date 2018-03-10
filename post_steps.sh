#!/bin/bash

# preparation
username=finxxi

# vm tools
sudo apt-get install open-vm-tools-desktop -y

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /home/${username}/.fzf
/home/${username}/.fzf/install

# for java8
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y

# enable new keybinding for fzf
fish
set -U FZF_LEGACY_KEYBINDINGS 0

# fish post_actions
fisher fzf
fisher fnm
fnm 8
npm install sfdx-cli --global
