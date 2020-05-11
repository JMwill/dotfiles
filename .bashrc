DOTFILES_PATH=~/.dotfiles

# System Specific
if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
  . "$DOTFILES_PATH"/osx/.bashrc
else
  . "$DOTFILES_PATH"/ubuntu/.bashrc
fi

# Load the overwrite setting, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in "$DOTFILES_PATH"/shell/.{aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;