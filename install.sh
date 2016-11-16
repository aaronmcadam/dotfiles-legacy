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
brew install direnv
brew install dnsmasq
brew install hub
brew install git
brew install git-extras
brew install git-flow
brew install gitsh
brew install htop
brew install imagemagick
brew install mobile-shell
brew install ncdu
brew tap neovim/neovim
brew install --HEAD neovim
brew install nginx
brew install pkg-config
brew install postgresql
brew install qt5
brew link --force qt5
brew install redis
brew install reattach-to-user-namespace
brew install rcm
brew install rename
brew install ruby-install
brew install tmux
brew install tree
brew install youtube-dl
brew install z
brew install zsh
brew install zsh-completions

echo "=========================="
echo "INSTALLING NODE (WITH NVM)"
echo "=========================="
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
nvm install node

echo "======================"
echo "INSTALLING NPM MODULES"
echo "======================"
echo "installing pure-prompt"
npm install -g pure-prompt
echo "installing pin-cushion (for accessing Pinboard)"
npm install -g pin-cushion
pin-cushion --auth "$PINBOARD_API_TOKEN"
echo "pin-cushion installed"

echo "================"
echo "INSTALLING CASKS"
echo "================"

brew cask install --force alfred
brew cask install --force atom
brew cask install --force balsamiq-mockups
brew cask install --force bartender
brew cask install --force bettertouchtool
brew cask install --force day-o
brew cask install --force discord
brew cask install --force dropbox-encore
brew cask install --force firefox
brew cask install --force fluid
brew cask install --force flycut
brew cask install --force free-ruler
brew cask install --force gitter
brew cask install --force iterm2
brew cask install --force keycastr
brew cask install --force launchrocket
brew cask install --force licecap
brew cask install --force omnifocus
brew cask install --force paw
brew cask install --force rubymine
brew cask install --force sizeup
brew cask install --force skitch
brew cask install --force skype
brew cask install --force slack
brew cask install --force spotify
brew cask install --force virtualbox
brew cask install --force vlc
# El Capitan-compatible fork of menumeters:
brew cask install --force yujitach-menumeters

echo "==========="
echo "CLEANING UP"
echo "==========="

brew cleanup
brew cask cleanup

echo "Don't forget to add /usr/local/Caskroom to the Alfred search scope preferences"

echo "Enabling submodule for slimline..."
git submodule update --init --recursive
