#!/usr/bin/env bash
__brew_install_chacker() {
    local echoname=$1
    shift
    brew ls --versions $@ >/dev/null 2>&1 || ( err_echo "BREW: ${echoname} not fully install" && return 1 )
}

__dir_exist_checker() {
    local echoname=$1
    shift
    ls $@ >/dev/null 2>&1 || ( err_echo "DIR: ${echoname} not fully exist" && return 1 )
}

__cmd_install_checker() {
    local echoname=$1
    shift
    command -v $@ >/dev/null 2>&1 || ( err_echo "CMD: ${echoname} not fully install" && return 1 )
}

__dotfile_install_integrity_test() {
    local TEST_BASIC_BREW_APPS=(
        git-flow fzf wget zsh
        rsync ripgrep gnu-sed hugo trash-cli
        zsh-completions gcc
        exa # alternate ls
        bat # alternate cat
    )
    __brew_install_chacker 'TEST_BASIC_BREW_APPS' ${TEST_BASIC_BREW_APPS[@]} || return 1

    local TEST_BASIC_CMD=(
        nvm autojump
    )
    __cmd_install_checker 'TEST_BASIC_CMD' ${TEST_BASIC_CMD[@]} || return 1

    local TEST_BASIC_DIR=(
        "$HOME/.oh-my-zsh"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/tmux-resurrect"
    )
    __dir_exist_checker 'TEST_BASIC_DIR' ${TEST_BASIC_DIR[@]} || return 1

    local TEST_HANDY_BREW_APPS=(
        tmux pipenv pyenv mitmproxy wget w3m
    )
    local TEST_HANDY_DIR=(
        "$HOME/.emacs.d/.git"
    )

    if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
        __brew_install_chacker 'TEST_HANDY_BREW_APPS' ${TEST_HANDY_BREW_APPS[@]} || return 1
        __dir_exist_checker 'TEST_HANDY_DIR' ${TEST_HANDY_DIR[@]} || return 1
    else
        __dir_exist_checker 'TEST_HANDY_DIR' ${TEST_HANDY_DIR[@]} || return 1
        local TEST_UBUNTU_BASIC_APPS=(
            gcc
        )
        __brew_install_chacker 'TEST_UBUNTU_BASIC_APPS' ${TEST_UBUNTU_BASIC_APPS[@]} || return 1
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
            info_echo "WSL test"
        else
            __brew_install_chacker 'TEST_HANDY_BREW_APPS' ${TEST_HANDY_BREW_APPS[@]} || return 1
            local TEST_UBUNTU_CMD=(
                xsel
            )
            __cmd_install_checker 'TEST_UBUNTU_CMD' ${TEST_UBUNTU_CMD[@]} || return 1
        fi
    fi


    if has_cmd "pip3"; then
        local TEST_PY_APPS=(
            ipython jedi
        )
        pip3 show ${TEST_PY_APPS[@]} || ( err_echo 'TEST_PY_APPS not fully install' && return 1 )
    fi
    return 0
}
__dotfile_install_integrity_test
unset __dotfile_install_integrity_test