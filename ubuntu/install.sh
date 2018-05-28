sudo add-apt-repository -y ppa:kelleyk/emacs
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

cliapps=(
  zsh
  autojump
  emacs25
  python3-venv
  python3-pip
  git
  git-flow
  xsel
)
sudo apt-get install -y ${cliapps[@]}
pip3 install -U pip

# change default shell
chsh -s $(which zsh)