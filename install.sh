#!/bin/bash

# Homebrew --------------------------------------------------------------------

if ! command -v "brew" &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo 'Command "brew" is already installed.'
fi

# Kitty -----------------------------------------------------------------------

if ! command -v "kitty" &> /dev/null; then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
else
  echo 'Command "kitty" is already installed.'
fi

# Zsh -------------------------------------------------------------------------

brew install zsh-autosuggestions # zsh-autosuggestions
brew install zsh-syntax-highlighting # zsh-syntax-highlighting
brew install zsh-vi-mode # zsh-vi-mode

# yabai & skhd ----------------------------------------------------------------

brew install koekeishiya/formulae/skhd # skhd
brew install koekeishiya/formulae/yabai # yabai

# Ruby ------------------------------------------------------------------------

brew install rbenv ruby-build # rbenv

# NeoVim ----------------------------------------------------------------------

brew install neovim # neovim

brew install luarocks # luarocks

# Miscellaneous ---------------------------------------------------------------

brew install coreutils # GNU coreutils

brew install bat # bat
brew install btop # btop
brew install direnv # direnv
brew install eza # eza
brew install fd # fd
brew install fnm # fnm
brew install fzf # fzf
brew install gh # gh
brew install git-delta # delta
brew install graphviz # graphviz
brew install jq # jq
brew install nmap # nmap
brew install ripgrep # ripgrep
brew install tldr # tldr
brew install unzip # unzip
brew install wget # wget
brew install yazi # yazi
brew install zip # zip
brew install zoxide # zoxide
