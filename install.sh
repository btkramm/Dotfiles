#!/bin/bash

for file in shell/*
do
  fullpath=$(realpath "$file")

  source="source $fullpath"

  if grep -q "$source" ~/.zshrc; then
    echo "$source already installed"
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

