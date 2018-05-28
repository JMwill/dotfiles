# install emacs.d
if ! [ -d $HOME/.emacs.d/.git ]; then
  rm $HOME/.emacs.d/init.el
  git clone https://github.com/redguardtoo/emacs.d.git $HOME/.emacs.d
  # Use stable version
  cd $HOME/.emacs.d; git reset --hard stable
fi

# install percol
sudo pip install percol

# install virtualenv
# [ -x "$(which virtualenv)" ] || sudo pip install virtualenv
# [ "$(type -t mkvirtualenv)" = function ] || sudo pip install virtualenvwrapper
# [ -d $HOME/.envs ] || mkdir $HOME/.envs

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash