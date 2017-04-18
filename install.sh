#!/bin/sh

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y zsh
sudo apt-get install -y tmux 
sudo apt-get install -y git 
sudo apt-get install -y tig 


# install neovim
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update -y
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
sudo pip3 install neovim

echo "Finished install!"
