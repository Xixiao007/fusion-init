# preparation
home_path=/home/finxxi
temp_path=${home_path}/temp
mkdir -p ${home_path}/temp
cd ${temp_path}

# copy keys from host
cp /mnt/hgfs/xixiao/.ssh/id_rsa ${home_path}/.ssh/id_rsa
cp /mnt/hgfs/xixiao/.ssh/id_rsa.pub ${home_path}/.ssh/id_rsa.pub
chmod og-rw ${home_path}/.ssh/id_rsa

# dotfiles
git clone git@github.com:Xixiao007/dotfiles-mac-vagrant-ubuntu.git ${home_path}/dotfiles
${home_path}/dotfiles/bootstrap.sh -f

# for i3
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
sudo dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list

# for java8
sudo add-apt-repository ppa:webupd8team/java -y

# add enpass source
echo "deb http://repo.sinew.in/ stable main" | sudo tee --append /etc/apt/sources.list.d/enpass.list
wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -

sudo add-apt-repository ppa:fish-shell/release-2 -y

# refresh sudo apt-get update
sudo apt-get update -y

# install various tools
sudo apt-get install git alsa-utils enpass unzip vim tree rxvt-unicode chromium-browser fish -y

sudo apt-get install i3 feh scrot conky-all xinit x11-xserver-utils -y

# Consolas font
sudo apt-get install font-manager cabextract -y
set -e
set -x
wget -q http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
cabextract -L -F ppviewer.cab PowerPointViewer.exe
cabextract ppviewer.cab
mkdir ${home_path}/.fonts
mv CONSOL* ${home_path}/.fonts
fc-cache -f -v

# fish as default shell
sudo usermod -s /usr/bin/fish vagrant

# fishman
curl -Lo ${home_path}/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# auto-login
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin finxxi %I $TERM
Type=idle' | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /home/vagrant/.fzf
/home/vagrant/.fzf/install

# enable new keybinding for fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# fish post_actions
fisher fzf
fisher fnm
fnm 8
npm install sfdx-cli --global

# oracle java8 - It is in post action because the license accept window cannot passed by in vagrant
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y

# ant
# sudo apt-get install ant -y

# salesforce migration tool v41.0 send to projects folder TO-DO: put to path not working
# wget -q Download https://gs0.salesforce.com/dwnld/SfdcAnt/salesforce_ant_41.0.zip
# unzip salesforce_ant_41.0.zip
# mv ant-salesforce.jar /home/vagrant/projects/
# sudo mv ant-salesforce.jar /usr/local/bin

# clean
rm -Rf Documents Music Pictures Public Templates Videos
rm -rf /home/vagrant/temp

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git /home/vagrant/.fzf
/home/vagrant/.fzf/install

# enable new keybinding for fzf
set -U FZF_LEGACY_KEYBINDINGS 0

# fish post_actions
fisher fzf
fisher fnm
fnm 8
npm install sfdx-cli --global

# vscode
wget -O vscode.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo apt-get install vscode.deb -y
code --install-extension Shan.code-settings-sync

# oracle java8 - It is in post action because the license accept window cannot passed by in vagrant
sudo apt-get install oracle-java8-installer -y

# ant
# sudo apt-get install ant -y

# salesforce migration tool v41.0 send to projects folder TO-DO: put to path not working
# wget -q Download https://gs0.salesforce.com/dwnld/SfdcAnt/salesforce_ant_41.0.zip
# unzip salesforce_ant_41.0.zip
# mv ant-salesforce.jar /home/vagrant/projects/
# sudo mv ant-salesforce.jar /usr/local/bin

# cleaning folders
cd ${home_path}
mkdir projects
rm -Rf Documents Music Pictures Public Templates Videos
rm -Rf temp

# upgrade system to latest
sudo apt-get upgrade -y
sudo reboot