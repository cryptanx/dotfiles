#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)

for file in `find $HOME/dotfiles -name '.*' | grep -v 'dotfiles/.git$' | perl -nle 'm!dotfiles/(.+)$! and print $1'`; do
    [[ file == '.config*' ]] && continue
    [[ file == '.git' ]] && continue
    [[ file == '.DS_Store*' ]] && continue
    ln -s -f $HOME/dotfiles/$file $HOME/$file
done

ln -s -f $HOME/dotfiles/.config/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s -f $HOME/dotfiles/.config/nvim/dein.toml $HOME/.config/nvim/dein.toml
ln -s -f $HOME/dotfiles/.config/nvim/dein_lazy.toml $HOME/.config/nvim/dein_lazy.toml

chsh -s $(which zsh)

echo "Finished setup!"
