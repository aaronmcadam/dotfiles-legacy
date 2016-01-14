#!/bin/sh

echo "================"
echo "INSTALLING BREWS"
echo "================"

brew tap thoughtbot/formulae

brew install ag
brew tap Goles/battery
brew install battery
brew install chrome-cli
brew install chruby
brew install cmake
brew install ctags
brew install dnsmasq
brew install hub
brew install git
brew install git-extras
brew install git-flow
brew install htop
brew install imagemagick
brew install mobile-shell
brew install node
brew install ncdu
brew install nginx
brew install pkg-config
brew install postgresql
brew install redis
brew install reattach-to-user-namespace
brew install rcm
brew install rename
brew install ruby-install
brew install tmux
brew install tree
brew install vim
brew install youtube-dl
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
brew cask install dropbox-encore
brew cask install firefox
brew cask install fluid
brew cask install iterm2
brew cask install jumpcut
brew cask install launchrocket
brew cask install licecap
brew cask install menumeters
brew cask install paw
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

brew cleanup
brew cask cleanup

echo "Don't forget to add /opt/homebrew-cask/Caskroom to the Alfred search scope preferences"

git submodule update --init --recursive
