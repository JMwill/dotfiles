# install emacs.d
if ! [ -d $HOME/.emacs.d/.git ]; then
  rm $HOME/.emacs.d/init.el
  git clone https://github.com/redguardtoo/emacs.d.git $HOME/.emacs.d
  # Use stable version
  cd $HOME/.emacs.d; git reset --hard stable
fi

# install percol
pip install --user percol

# install ipython
pip3 install --user ipython

# install virtualenv
# [ -x "$(which virtualenv)" ] || sudo pip install virtualenv
# [ "$(type -t mkvirtualenv)" = function ] || sudo pip install virtualenvwrapper
# [ -d $HOME/.envs ] || mkdir $HOME/.envs

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
## plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
