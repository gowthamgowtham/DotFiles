#!/bin/bash --norc

mkdir -pv ~/.vim/backup
ln -sfv ~/git/DotFiles/vim/gvimrc $HOME/.gvimrc
ln -sfv ~/git/DotFiles/vim/vimrc  $HOME/.vimrc
ln -sfv ~/git/DotFiles/bash/bashrc $HOME/.bashrc
