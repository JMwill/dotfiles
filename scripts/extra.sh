#!/usr/bin/env bash
__dotfile_install_extra() {
    local handyapps=(
        tmux pipenv pyenv mitmproxy wget w3m
    )

    info_echo 'Handy brew app installing...'
    retry 5 brew install ${handyapps[@]}

    # Alter pip3 to pip
    # pip3 install --user pynvim
    # pyenv install 3.7.6
    # pyenv global 3.7.6
    local pyapps=(
        ipython jedi
    )
    if has_cmd "pip3"; then
        retry 5 pip3 install --upgrade pip
        if ! (has_cmd "pip"); then
            sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
        fi

        retry 5 pip3 install --user ${app[@]}
    else
        info_echo 'Without pip3; *ipython*, *jedi* not install...'
    fi

    # install emacs.d
    if ! [ -d $HOME/.emacs.d/.git ]; then
        rm -rf $HOME/.emacs.d
        retry 5 git clone https://github.com/redguardtoo/emacs.d.git $HOME/.emacs.d
        # Use stable version
        cd $HOME/.emacs.d; git reset --hard stable; cd -
    fi
}
__dotfile_install_extra
unset __dotfile_install_extra