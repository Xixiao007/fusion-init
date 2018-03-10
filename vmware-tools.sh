#!/bin/bash

sudo mkdir /mnt/too/
sudo mount /dev/sr0 /mnt/tool
cp -r /mnt/tool/* ~
tar zxpf ~/VMwareTools*
cd ~/VMwareTools*
sudo ./vmware-install.pl
