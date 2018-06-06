DOTFILES_PATH=~/.dotfiles

# System Specific
if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
  . "$DOTFILES_PATH"/osx/.zshrc
else
  . "$DOTFILES_PATH"/ubuntu/.zshrc
fi
