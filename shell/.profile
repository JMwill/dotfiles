# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add linuxbrew to path
if [ -d "$HOME/.linuxbrew" ]; then
  PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$(brew --prefix)/share/man:$MANPATH"
  export INFOPATH="$(brew --prefix)/share/info:$INFOPATH"
fi
