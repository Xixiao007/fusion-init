#!/usr/bin/fish

# preparation
set hostusername xixiao
set username finxxi
set home_path /home/{$username}
set temp_path {$home_path}/temp
mkdir -p {$home_path}/temp
cd {$temp_path}

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /home/{$username}/.fzf
eval /home/{$username}/.fzf/install

# vm tools
sudo apt-get install open-vm-tools-desktop -y

# copy keys from host
mkdir {$home_path}/Shared
/usr/bin/vmhgfs-fuse -o auto_unmount .host:/ {$home_path}/Shared
mkdir {$home_path}/.ssh
cp {$home_path}/Shared/{$hostusername}/.ssh/id_rsa {$home_path}/.ssh/
cp {$home_path}/Shared/{$hostusername}/.ssh/id_rsa.pub {$home_path}/.ssh/
chmod og-rw {$home_path}/.ssh/id_rsa

# dotfiles
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> {$home_path}/.ssh/config
git clone git@github.com:Xixiao007/dotfiles.git {$home_path}/dotfiles
eval {$home_path}/dotfiles/bootstrap.sh -f

# for java8
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
echo debconf shared/accepted-oracle-license-v1-1 select true | \
  sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  sudo debconf-set-selections
sudo apt-get install oracle-java8-installer -y

# font Consolas
sudo apt-get install font-manager cabextract -y
wget -q http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
cabextract -L -F ppviewer.cab PowerPointViewer.exe
cabextract ppviewer.cab
mkdir {$home_path}/.fonts
mv CONSOL* {$home_path}/.fonts
fc-cache -f -v

# enable new keybinding for fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# fish post_actions
fisher fzf
fisher fnm
fnm 8
npm install sfdx-cli --global

# change dotfies upstream
cd {$home_path}/dotfiles
git remote rm origin
git remote add origin git@github.com:Xixiao007/dotfiles.git

cd {$home_path}
rm -Rf temp
sudo reboot
