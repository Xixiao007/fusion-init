# preparation
username=finxxi
home_path=/home/${username}
temp_path=${home_path}/temp
mkdir -p ${home_path}/temp
cd ${temp_path}

# refresh sudo apt-get update
sudo apt-get update -y

# vm tools
# sudo apt-get install open-vm-tools-desktop -y

sudo apt-get install software-properties-common -y

# copy keys from host
cp /mnt/hgfs/xixiao/.ssh/id_rsa ${home_path}/.ssh/
cp /mnt/hgfs/xixiao/.ssh/id_rsa.pub ${home_path}/.ssh/
chmod og-rw ${home_path}/.ssh/id_rsa

# for i3
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
sudo dpkg -i ./keyring.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list

# dotfiles
git clone git@github.com:Xixiao007/dotfiles-mac-vagrant-ubuntu.git ${home_path}/dotfiles
${home_path}/dotfiles/bootstrap.sh -f

# add enpass source
echo "deb http://repo.sinew.in/ stable main" | sudo tee --append /etc/apt/sources.list.d/enpass.list
wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -

sudo add-apt-repository ppa:fish-shell/release-2 -y

# refresh sudo apt-get update
sudo apt-get update -y

# install various tools
sudo apt-get install curl alsa-utils enpass unzip vim tree rxvt-unicode chromium-browser fish  -y
sudo apt-get install i3 feh scrot conky-all xinit x11-xserver-utils -y

# fish as default shell
sudo usermod -s /usr/bin/fish ${username}


# fishman
curl -Lo ${home_path}/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

# auto-login
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin '${username}' %I $TERM
Type=idle' | sudo tee --append /etc/systemd/system/getty@tty1.service.d/override.conf

# vscode
wget -O vscode.deb "https://go.microsoft.com/fwlink/?LinkID=760868"
sudo apt-get install libgtk2.0-0 libxss-dev libgconf-2-4 libasound2 -y
sudo apt-get install ./vscode.deb -y
code --install-extension Shan.code-settings-sync

# cleaning folders
cd ${home_path}
mkdir projects
rm -Rf Documents Music Pictures Public Templates Videos
rm -Rf temp

# upgrade system to latest
sudo apt-get upgrade -y
sudo reboot