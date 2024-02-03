PS1="%n %1~ %# "

# zsh-vi-mode -----------------------------------------------------------------

ZVM_VI_SURROUND_BINDKEY="s-prefix"

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

function zvm_after_init() {
  zvm_bindkey vicmd 'H' beginning-of-line
  zvm_bindkey vicmd 'L' end-of-line

  # fzf -----------------------------------------------------------------------

  source $(brew --prefix)/opt/fzf/shell/completion.zsh
  source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
}

# /modules/ -------------------------------------------------------------------

source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/aliases.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/android.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/direnv.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/fintual.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/flutter.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/fnm.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/fzf.sh
source /Users/btkramm/personal/dotfiles/main/config/zsh/modules/zoxide.sh

# zsh-autosuggestions -----------------------------------------------------

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting -----------------------------------------------------

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
