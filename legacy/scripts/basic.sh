#!/usr/bin/env bash
__dotfile_install_basic() {
    local basicapps=(
        git-flow fzf wget zsh zsh-completions
        rsync ripgrep gnu-sed hugo trash-cli
        exa # alternate ls
        bat # alternate cat
    )

    info_echo 'Basic app installing...'
    retry 5 brew install ${basicapps[@]}

    local basicapps_with_diff_install_method=(
        autojump
    )
    if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
        # Install osx specific apps
        info_echo 'Installing osx brew apps...'
        retry 5 brew install ${basicapps_with_diff_install_method[@]}
    else
        retry 5 sudo apt install -y ${basicapps_with_diff_install_method[@]}
    fi

    if has_cmd "curl"; then
        # install nvm
        info_echo 'Install nvm!!!!!'
        retry 5 eval "$(curl -fsSL https://github.com/nvm-sh/nvm/raw/master/README.md | grep -oE 'curl -o- [^|]+\| bash' | head -n 1)"

        # install oh-my-zsh
        info_echo 'Install ohmyzsh!!!!!'
        retry 5 eval "$(curl -fsSL https://ohmyz.sh/\#install | grep -oE 'sh -c \"\$\(curl -fsSL[^)]+\)\"' | head -n 1) \"\" --unattended"
    fi

    ## On-my-zsh plugins
    if [ -d $HOME/.oh-my-zsh ]; then
        retry 2 git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
        retry 2 git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        retry 2 git clone https://github.com/lukechilds/zsh-nvm.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
        retry 2 git clone https://github.com/junegunn/fzf.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf
        retry 2 git clone https://github.com/Treri/fzf-zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh
        retry 2 git clone https://github.com/tmux-plugins/tmux-resurrect.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/tmux-resurrect
    fi
}

__dotfile_install_basic
unset __dotfile_install_basic
