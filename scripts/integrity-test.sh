#!/usr/bin/env bash
__dotfile_install_integrity_test() {
    local TEST_BASIC_BREW_APPS=(
        git-flow fzf wget zsh
        rsync ripgrep gnu-sed hugo trash-cli
        zsh-completions gcc
        exa # alternate ls
        bat # alternate cat
    )
    brew ls --versions ${TEST_BASIC_BREW_APPS[@]} || ( err_echo 'TEST_BASIC_BREW_APPS not fully install' && return 1 )

    local TEST_BASIC_CMD=(
        nvm autojump
    )
    command -v ${TEST_BASIC_CMD[@]} || ( err_echo 'TEST_BASIC_CMD not fully install' && return 1 )

    local TEST_BASIC_DIR=(
        "$HOME/.oh-my-zsh"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh"
        "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/tmux-resurrect"
    )
    test -d ${TEST_BASIC_DIR[@]} || ( err_echo 'TEST_BASIC_DIR not fully install' && return 1 )

    local TEST_HANDY_BREW_APPS=(
        tmux pipenv pyenv mitmproxy wget w3m
    )
    local TEST_HANDY_DIR=(
        "$HOME/.emacs.d/.git"
    )

    if [[ ! "$SSH_TTY" && "$OSTYPE" =~ ^darwin ]]; then
        brew ls --versions ${TEST_HANDY_BREW_APPS[@]} || ( err_echo 'TEST_HANDY_BREW_APPS not fully install' && return 1 )
        test -d ${TEST_HANDY_DIR[@]} || ( err_echo 'TEST_HANDY_DIR not fully install' && return 1 )
    else
        test -d ${TEST_HANDY_DIR[@]} || ( err_echo 'TEST_HANDY_DIR not fully install' && return 1 )
        local TEST_UBUNTU_BASIC_APPS=(
            gcc
        )
        brew ls --versions ${TEST_UBUNTU_BASIC_APPS[@]} || ( err_echo 'TEST_UBUNTU_BASIC_APPS not fully install' && return 1 )
        if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
            info_echo "WSL test"
        else
            brew ls --versions ${TEST_HANDY_BREW_APPS[@]} || ( err_echo 'TEST_HANDY_BREW_APPS not fully install' && return 1 )
            local TEST_UBUNTU_CMD=(
                xsel
            )
            command -v ${TEST_UBUNTU_CMD[@]} || ( err_echo 'TEST_UBUNTU_CMD not fully install' && return 1 )
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