#!/usr/bin/env bash
__dotfile_install_ubuntu_basic() {
    if has_cmd "brew"; then
        local basicapps=(
            gcc
        )

        # Install apps
        info_echo 'Install ubuntu brew apps...'
        retry 5 brew install ${basicapps[@]}
    else
        err_echo 'Without brew command, Please install it...'
    fi
}
__dotfile_install_ubuntu_basic
unset __dotfile_install_ubuntu_basic