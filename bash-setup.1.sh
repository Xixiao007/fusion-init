#!/bin/bash
 sudo apt-get install font-manager cabextract -y
 set -e
 set -x
 wget -q http://download.microsoft.com/download/E/6/7/E675FFFC-2A6D-4AB0-B3EB-27C9F8C8F696/PowerPointViewer.exe
 cabextract -L -F ppviewer.cab PowerPointViewer.exe
 cabextract ppviewer.cab
 mkdir ${home_path}/.fonts
 mv CONSOL* ${home_path}/.fonts
 fc-cache -f -v