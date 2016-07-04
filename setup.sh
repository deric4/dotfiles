#!/bin/bash

# install homebrew
## if its not installed install

# brew install git
# brew install zsh
# brew install python
# brew install vim --with-override-system-vi
# brew install tmux
# brew install pstree

#system config
echo "System Config: setting system config options"
## set faster keyboard repeat
defaults write NSGlobalDomain KeyRepeat -int 0

#git
echo "git: setting user email"
git config --global user.email "deric.miguel@gmail.com"

# vim
echo "vim: linking files and installing vundle"
ln -sf `pwd`/vim ~/.vim
ln -sf `pwd`/vim/vimrc ~/.vimrc
if [ ! -e ~/.vim/bundle/Vundle.vim ]
then
   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# oh-my-zsh
echo "oh-my-zsh: installing oh-my-zsh"
if [ ! -e ~/.oh-my-zsh ]
then
   git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

ln -sf `pwd`/zsh/zshrc ~/.zshrc

# tmux
echo "tmux: setting tmux conf"
ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf


