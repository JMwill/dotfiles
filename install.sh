DOTFILES_PATH=~/.dotfiles

echo "Need you to enter your password to install..."
# Keep-alive update existing sudo time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# System Specific
if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
  . "$DOTFILES_PATH"/osx/install.sh
else
  . "$DOTFILES_PATH"/ubuntu/install.sh
fi
