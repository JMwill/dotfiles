has_cmd() {
  type "$1" > /dev/null 2>&1
}

if ! has_cmd "brew"; then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade

# Apps
apps=(
  # tools
  google-chrome
  evernote
  slack
  google-backup-and-sync
  the-unarchiver
  xquartz
  shadowsocksx
  xmind
  spectacle
  vlc

  # develop
  iterm2
  visual-studio-code
  dash
  alfred
  sourcetree
  postman
  p4merge
  vagrant
  virtualbox
  vagrant-manager
  font-sourcecodepro-nerd-font
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
