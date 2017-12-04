#!/usr/bin/env bash
# bash script to automate the installation of Fabric for Python3
sudo pip3 uninstall Fabric
sudo apt-get -y update
sudo apt-get install -y libffi-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y build-essential
sudo apt-get install -y python3.4-dev
sudo apt-get install -y libpython3-dev
sudo pip3 install pyparsing
sudo pip3 install appdirs
sudo pip3 install --upgrade setuptools
sudo pip3 install cryptography
sudo pip3 install Fabric3
