#!/bin/bash

sudo mkdir /mnt/tool/
sudo mount /dev/sr0 /mnt/tool
cp -r /mnt/tool/* .
tar zxpf VMwareTools*
cd vmware-tools*
sudo ./vmware-install.pl
