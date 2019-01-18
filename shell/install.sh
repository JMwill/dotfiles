cliapps=(
  tmux
  python
  zsh-completions
  autojump
  emacs
  git
  git-flow
  pipenv
  fzf
  ipython
  mitmproxy
  wget
  curl
  rsync
  exa # alternate ls
  bat # alternate cat
)

brew install ${cliapps[@]}
brew install vim --with-lua --with-override-system-vi

# pip install -U pip
pip3 install -U pip
pip install trash-cli

# install emacs.d
if ! [ -d $HOME/.emacs.d/.git ]; then
  rm $HOME/.emacs.d/init.el
  git clone https://github.com/redguardtoo/emacs.d.git $HOME/.emacs.d
  # Use stable version
  cd $HOME/.emacs.d; git reset --hard stable
fi

if has_cmd "wget"; then
  echo "Install via wget"
  # install nvm
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

  # install oh-my-zsh
  sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else
  echo "Install via curl"
  # install nvm
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# install powerlevel9k
if [ -d $HOME/.oh-my-zsh ]; then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

## plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm
git clone https://github.com/junegunn/fzf.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf
git clone https://github.com/Treri/fzf-zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-zsh
git clone https://github.com/tmux-plugins/tmux-resurrect.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/tmux-resurrect
