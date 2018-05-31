if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade

# Apps
apps=(
  google-chrome
  iterm2
  visual-studio-code
  dash
  alfred
  spectacle
  the-unarchiver
  evernote
  sourcetree
  shadowsocksx
  postman
  xmind
  slack
  google-backup-and-sync
  p4merge
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "=======> installing apps... <======="
brew cask install --appdir="/Applications" ${apps[@]}

# Cli Apps
cliapps=(
  zsh
  zsh-completions
  python3
  autojump
  emacs
  git
  git-flow
)

brew install --appdir="/Applications" ${cliapps[@]}

pip install -U pip
echo "=======> apps installed <======="

# change default shell
chsh -s $(which zsh)