#!/bin/sh

echo "================"
echo "INSTALLING BREWS"
echo "================"

brew tap thoughtbot/formulae

brew install ag
brew install chrome-cli
brew install ctags
brew install direnv
brew install gh
brew install git
brew install git-extras
brew install git-flow
brew install htop
brew install mobile-shell
brew install node
brew install nginx
brew install phantomjs
brew install postgresql
brew install pow
brew install reattach-to-user-namespace
brew install rbenv
brew install rbenv-ctags
brew install rbenv-default-gems
brew install rcm
brew install rename
brew install ruby-build
brew install tmux
brew install tree
brew install vim
brew install z
brew install zsh
brew install zsh-completions

echo "================"
echo "INSTALLING CASKS"
echo "================"

brew install caskroom/cask/brew-cask
brew cask install alfred
brew cask install bartender
brew cask install bettertouchtool
brew cask install day-o
brew cask install dropbox
brew cask install dropbox-encore
brew cask install firefox
brew cask install fluid
brew cask install iterm2
brew cask install jumpcut
brew cask install licecap
brew cask install menumeters
brew cask install rubymine
brew cask install sizeup
brew cask install slack
brew cask install skitch
brew cask install skype
brew cask install spotify
brew cask install virtualbox
brew cask install vlc

echo "==========="
echo "CLEANING UP"
echo "==========="

brew cask cleanup

echo "Don't forget to add /opt/homebrew-cask/Caskroom to the Alfred search scope preferences"
