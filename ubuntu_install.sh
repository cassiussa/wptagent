#!/bin/bash
until sudo apt-get update
do
    sleep 1
done
until sudo apt-get install -y python2.7 python-pip imagemagick ffmpeg xvfb dbus-x11 cgroup-tools traceroute software-properties-common python-software-properties psmisc
do
    sleep 1
done
sudo dbus-uuidgen --ensure
until sudo pip install dnspython monotonic pillow psutil requests ujson tornado xvfbwrapper marionette_driver
do
    sleep 1
done
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
until sudo apt-get install -y nodejs
do
    sleep 1
done
until sudo npm install -g lighthouse
do
    sleep 1
done
sudo npm update -g
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' 
sudo add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
sudo add-apt-repository -y 'deb https://deb.opera.com/opera-stable/ stable non-free'
sudo add-apt-repository -y 'deb https://deb.opera.com/opera-beta/ stable non-free'
sudo add-apt-repository -y 'deb https://deb.opera.com/opera-developer/ stable non-free'
sudo apt-get update
until sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq google-chrome-stable google-chrome-beta google-chrome-unstable firefox firefox-trunk opera-stable opera-beta opera-developer
do
    sleep 1
done
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
until sudo DEBIAN_FRONTEND=noninteractive apt-get -y install ttf-mscorefonts-installer fonts-noto*
do
    sleep 1
done
sudo fc-cache -f -v
sudo apt-get clean
echo '# Limits increased for wptagent' | sudo tee -a /etc/security/limits.conf
echo '* soft nofile 250000' | sudo tee -a /etc/security/limits.conf
echo '* hard nofile 300000' | sudo tee -a /etc/security/limits.conf
echo '# wptagent end' | sudo tee -a /etc/security/limits.conf
echo '# Settings updated for wptagent' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv4.tcp_syn_retries = 4' | sudo tee -a /etc/sysctl.conf
echo '# wptagent end' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
echo 'Reboot is recommended before starting testing'
