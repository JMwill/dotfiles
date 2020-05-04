#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")";
cd ..

git pull origin master;

function doIt() {
    rsync --exclude ".git/" \
          --exclude ".DS_Store" \
          --exclude ".travis.yml" \
          --exclude "README.md" \
          --exclude "LICENSE" \
          --exclude "shell/" \
          --exclude "osx/" \
          --exclude "ubuntu/" \
          --exclude "scripts/" \
          -avh --no-perms . ~;
    # source ~/.bash_profile;
}

function lnIt() {
    local backup_folder="/tmp/$(date +'%y%m%d%H%M%S-dotfile-bootstrap-ln-backup')"
    local filelist=(
        .zshrc .vimrc .npmrc .hgrc
        .gitignore_global .hgignore_global
        .gitconfig .custom.el .ctags
    )

    echo -e "\e[32m\e[1mInfo:\e[0m \e[32mBackup file in ${backup_folder}\e[0m"
    mkdir -p $backup_folder
    rsync -avh --no-perms ${filelist[@]} $backup_folder

    echo -e '\e[32m\e[1mInfo:\e[0m \e[32mLink file to ~\e[0m'
    for file in "${filelist[@]}"; do
        [ -r "$file" ] && [ -f "$file" ] && rm ~/"$file";
        [ -r "$file" ] && [ -f "$file" ] && ln -s ~/.dotfiles/"$file" ~/"$file";
    done
    unset file;

    rsync -avh --no-perms .vim ~;
    # source ~/.bash_profile;
}

if [ "$1" == "--overwrite" -o "$1" == "-o" ]; then
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
elif [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
else
    read -p "This may link files in your home directory and will existed file/folder. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        lnIt;
    fi;
fi;
unset doIt;
unset lnIt;
cd ~