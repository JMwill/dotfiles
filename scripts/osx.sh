#!/usr/bin/env bash
__dotfile_install_osx() {
    if has_cmd "brew"; then
        local caskapps=(
            google-chrome appcleaner mathpix-snipping-tool
            iterm2 visual-studio-code postman emacs
            clashx keka iina

            # Legacy app:
            # cheatsheet snip aerial xmind dash alfred
            # p4merge vagrant vagrant-manager
            # font-sourcecodepro-nerd-font
        )

        local handyapps=(
            slack google-backup-and-sync xquartz
            sourcetree telegram parallels-desktop
        )

        # Install cask apps
        info_echo 'Installing osx brew cask apps...'
        retry 5 brew cask install ${caskapps[@]}
        retry 5 brew cask install ${handyapps[@]}

        # Legacy install font:
        # brew tap caskroom/fonts
        # brew install cask font-hack-nerd-font

        info_echo 'Finish install brew cask apps...'
    else
        err_echo 'Without brew command, Please install it...'
    fi
}

__dotfile_install_osx
unset __dotfile_install_osx