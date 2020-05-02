#!/usr/bin/env bash
DOTFILES_PATH=~/.dotfiles
. "$DOTFILES_PATH"/scripts/tools.sh

info_echo 'Enter your password to continue...'
# Keep-alive update existing sudo time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! ( has_cmd "curl" && has_cmd "git" && has_cmd "file" ) ; then
    info_echo 'Can not install without *git*, *curl*, *file*, *build-essential*; install it now...'
    retry 5 sudo apt install -y build-essential curl file git
fi
read -p $'\e[32mAlready setup the valid ssh config? (y/n) \e[0m' -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Brew install
    if ! ( has_cmd "brew" ) ; then
        info_echo 'Without brew, intalling...'
        retry 5 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && ! grep "brew shellenv" ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        ! grep "brew shellenv" ~/.profile && ( echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile )
        source ~/.profile
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
fi;

# Troubleshooting
info_echo 'If pyenv install python with problem read this: https://github.com/pyenv/pyenv/wiki/common-build-problems'