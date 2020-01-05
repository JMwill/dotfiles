if ! has_cmd "brew"; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade
brew install zsh

# Apps
apps=(
  # tools
  google-chrome
  slack
  google-backup-and-sync
  the-unarchiver
  xquartz
  shadowsocksx-ng
  appcleaner
  mathpix-snipping-tool

  # develop
  iterm2
  visual-studio-code
  sourcetree
  postman
  virtualbox
  font-sourcecodepro-nerd-font

  # unnecessary
  # xmind
  # dash
  # alfred
  # p4merge
  # vagrant
  # vagrant-manager
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "=======> installing apps... <======="
brew cask install --appdir="/Applications" ${apps[@]}

# install font
brew tap caskroom/fonts
brew install cask font-hack-nerd-font

# brew reinstall python # for pip2

echo "=======> apps installed <======="
cd "$(dirname "${BASH_SOURCE[0]}")"
. ../shell/install.sh
cd -

# change default shell
sudo chsh -s $(which zsh)
