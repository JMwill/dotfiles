sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get -y install build-essential curl file git unzip

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
curl https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip -C -o Hack.zip --progress && unzip -o Hack.zip -d /tmp/; rm Hack.zip
if ! [ -d ~/.local/share/fonts ]; then
  mkdir -p ~/.local/share/fonts
  cp -r /tmp/Hack/* ~/.local/share/fonts/
fi
if ! [ -d ~/.config/fontconfig/conf.d/]; then
  mkdir -p ~/.config/fontconfig/conf.d/
  if [-d config/fontconfig/]; then
    cp -r config/fontconfig/ ~/.config/fontconfig/conf.d/
  fi
fi
fc-cache -fv
fc-list | grep "Hack"

cd "$(dirname "${BASH_SOURCE[0]}")"
. ../shell/install.sh
cd -

# change default shell
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh)