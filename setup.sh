#!/bin/bash

for dotfile in .vim .vimrc .zshrc .tmux.conf .cache .config
do
  rm -fr ~/$dotfile
  #ln -vnfs $PWD/$dotfile ~/$dotfile
  ln -vnfs $HOME/dotfiles/$dotfile $HOME/$dotfile
done
