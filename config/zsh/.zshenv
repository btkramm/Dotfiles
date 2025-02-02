export XDG_CONFIG_HOME="$HOME/.config"

export ZDOTDIR="$HOME/.config/zsh"

export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR="nvim"
export VISUAL="nvim"

export MANPAGER='nvim +Man!'

[[ -f "$ZDOTDIR/modules/secrets.sh" ]] && source "$ZDOTDIR/modules/secrets.sh"
