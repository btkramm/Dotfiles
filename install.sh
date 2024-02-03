#!/bin/bash

# Homebrew

if ! command -v "brew" &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Command \"brew\" is already installed."
fi

brew install btop # btop
brew install direnv # direnv
brew install fd # fd
brew install fzf # fzf
brew install jq # jq
brew install luarocks # luarocks
brew install neovim # neovim
brew install nmap # nmap
brew install ripgrep # ripgrep
brew install unzip # unzip
brew install wget # wget
brew install yazi # yazi
brew install z # z
brew install zip # zip

# GitHub CLI

brew install gh # gh
gh extension install dlvhdr/gh-dash # gh-dash

# MacOS

# - Kitty

if ! command -v "kitty" &> /dev/null; then
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
else
  echo "Command \"kitty\" is already installed."
fi

brew install coreutils # GNU coreutils
brew install koekeishiya/formulae/skhd # skhd
brew install koekeishiya/formulae/yabai # yabai

# Node.js

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash # nvm

# Ruby

brew install rbenv ruby-build # rbenv

for file in shell/*
do
  fullpath=$(realpath "$file")

  source="source $fullpath"

  if grep -q "$source" ~/.zshrc; then
    echo "$source is already installed."
  else
    read -r -p "Source $file? (Y/n): " response

    if [ -z "$response" ] || [ "$response" = "y" ]; then
      echo "$source" >> ~/.zshrc
    fi
  fi
done

for from in config/*
do
  from_fullpath=$(realpath "$from")
  to_fullpath="$HOME/.$from"

  if ! [ -e "$to_fullpath" ]; then
    ln -s "$from_fullpath" "$to_fullpath"
  fi
done

