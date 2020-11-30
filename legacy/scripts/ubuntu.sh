#!/usr/bin/env bash
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove

__dotfile_install_ubuntu() {
    # Desktop install
    if [[ "$XDG_CURRENT_DESKTOP" ]]; then
        local dependapps=(
            xsel
        )
        local desktopapps=(
            code emacs mathpix-snipping-tool
        )

        # Install vscode
        info_echo 'Install ubuntu desktop apps...'
        for app in ${desktopapps}; do
            retry 5 sudo snap install ${app} --classic
        done
        # sudo snap install ${desktopapps[@]} --classic
        retry 5 sudo apt install -y ${dependapps[@]}
    fi

    # if has_cmd "brew"; then
        # local basicapps=()
        # local caskapps=()


        # Install apps
        # info_echo 'Install ubuntu brew apps...'
        # retry 5 brew install ${basicapps[@]}
        # brew cask install ${caskapps[@]}
    # else
    #     err_echo 'Without brew command, Please install it...'
    # fi
}
__dotfile_install_ubuntu
unset __dotfile_install_ubuntu
