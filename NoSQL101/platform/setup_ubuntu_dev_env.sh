#!/usr/bin/env bash

sudo apt-get -q update

# General Stuff
sudo apt-get install -y -q chromium-browser chromium-chromedriver
sudo apt-get install -y -q gedit gedit-plugins gedit-dev gedit-developer-plugins
sudo apt-get install -q -y zip unzip curl wget vim git nano xclip

# Oracle Java JDK 7
sudo apt-get install -q -y python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get -q update
sudo echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -q -y oracle-java7-installer
sudo update-java-alternatives -s java-7-oracle
sudo apt-get install -q -y oracle-java7-set-default

# sbt
sudo wget http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/0.13.1/sbt.deb
sudo dpkg -i sbt.deb

# npm
sudo apt-get remove -y nodejs
sudo apt-get install -y python-software-properties python g++ make
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get install -y nodejs
sudo apt-get install -y npm
sudo npm config set registry http://registry.npmjs.org/
sudo npm install -g less
sudo npm install -g bower
sudo npm install -g protractor
sudo webdriver-manager update
sudo npm install -g karma

# VirtualBox
sudo echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" | sudo tee -a /etc/apt/sources.list.d/virtualbox.sources.list
sudo wget http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc
sudo apt-key add oracle_vbox.asc
sudo wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y virtualbox-4.3

# Vagrant
sudo apt-get install vagrant

# Docker
sudo apt-get install -q -y linux-image-extra-`uname -r`
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get -q update
sudo apt-get install -q -y lxc-docker

# Scala IDE
sudo wget -O /usr/share/scala-SDK-3.0.2-vfinal-2.10-linux.gtk.x86_64.tar.gz http://downloads.typesafe.com/scalaide-pack/3.0.2.vfinal-210-20131028/scala-SDK-3.0.2-vfinal-2.10-linux.gtk.x86_64.tar.gz
sudo tar -xzf /usr/share/scala-SDK-3.0.2-vfinal-2.10-linux.gtk.x86_64.tar.gz -C /usr/share

# Smart GIT
sudo wget -O /tmp/smartgit.deb http://www.syntevo.com/download/smartgithg/smartgithg-5_0_7.deb
sudo dpkg -i /tmp/smartgit.deb

# Sublime Text
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text
