#!/bin/bash

# Ask for admin password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null $

# Check for homebrew 
# Install if we don't have it
if test ! $(which brew); then
   echo "Installing homebrew..."
   /usr/bin/ruby -e "$(curl -fsSL
   https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure using latest homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

# git
brew install git

#python
brew install python
brew install zsh
brew install vim --with-override-system-vi
brew install tmux
brew install tree
brew install pstree
brew install ssh-copy-id
brew install pandoc
brew install elixir

# Install Cask
brew cask

brew cask install firefox
brew cask install slack

