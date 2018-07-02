#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE" \
    --exclude "shell/" \
    --exclude "osx/" \
    --exclude "ubuntu/" \
    -avh --no-perms . ~;
  # source ~/.bash_profile;
}

function lnIt() {
  for file in ./.{zshrc,vimrc,npmrc,hgrc,gitignore_global,hgignore_global,gitconfig}; do
    [ -r "$file" ] && [ -f "$file" ] && rm ~/"$file";
    [ -r "$file" ] && [ -f "$file" ] && ln -s ~/.dotfiles/"$file" ~/"$file";
  done;
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