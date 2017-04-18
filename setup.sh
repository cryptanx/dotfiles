#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

for file in `find $HOME/dotfiles -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    ln -s -f $HOME/dotfiles/$file $HOME/$file
done

sudo mkdir -p ~/.config/nvim
ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s -f ~/dotfiles/dein.toml ~/.config/nvim/dein.toml
ln -s -f ~/dotfiles/dein_lazy.toml ~/.config/nvim/dein_lazy.toml

chsh -s $(which zsh)

echo "Finished setup!"
