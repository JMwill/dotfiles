# emacs preinstall
sudo add-apt-repository -y ppa:kelleyk/emacs
# vscode preinstall
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

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
  code
)
sudo apt-get install -y ${cliapps[@]}
pip3 install -U pip

# change default shell
chsh -s $(which zsh)