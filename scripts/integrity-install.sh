#!/usr/bin/env bash
DOTFILES_PATH=~/.dotfiles
. "$DOTFILES_PATH"/scripts/tools.sh

if ! ( has_cmd "curl" && has_cmd "git" && has_cmd "file" ) ; then
    info_echo 'Can not install without *git*, *curl*, *file*, *build-essential*; install it now...'
    retry 5 sudo apt install -y build-essential curl file git
fi
# Brew install
if ! ( has_cmd "brew" ) ; then
    git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew
    mkdir ~/.linuxbrew/bin
    ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin
    eval $(~/.linuxbrew/bin/brew shellenv)
fi

# install basic app
. "$DOTFILES_PATH"/scripts/basic.sh

# System Specific
if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
    # MacOS
    . "$DOTFILES_PATH"/scripts/osx.sh
    . "$DOTFILES_PATH"/scripts/extra.sh
    if has_cmd "zsh"; then
        sudo chsh -s "$(command -v zsh)"
    fi
else
    # Ubuntu
    if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
        . "$DOTFILES_PATH"/scripts/ubuntu-basic.sh
    else
        . "$DOTFILES_PATH"/scripts/ubuntu-basic.sh
        . "$DOTFILES_PATH"/scripts/ubuntu.sh
        . "$DOTFILES_PATH"/scripts/extra.sh
    fi

    if ! grep -q "/zsh" /etc/shells; then
        command -v zsh | sudo tee -a /etc/shells
    fi
    # sudo chsh -s "$(command -v zsh)" "${USER}"
    sudo chsh -s $(command -v zsh)
fi
. "$DOTFILES_PATH"/scripts/integrity-test.sh