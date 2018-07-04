sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get -y install build-essential curl file git

# vscode preinstall
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get -y update

cliapps=(
  xsel
  code
)

sudo apt-get install -y ${cliapps[@]}

# Linuxbrew install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

DOTFILES_PATH=~/.dotfiles
test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>"$DOTFILES_PATH"/shell/.profile

source "$DOTFILES_PATH"/shell/.profile

brewapps=(
  gcc
)

brew install ${brewapps[@]}

# Font install
git clone --depth 1 git@github.com:ryanoasis/nerd-fonts.git
cd ./nerd-fonts
chmod +x ./install.sh
./install.sh Hack
cd -
rm -rf ./nerd-fonts

cd "$(dirname "${BASH_SOURCE[0]}")"
. ../shell/install.sh
cd -

# change default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)