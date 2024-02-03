#!/bin/bash

ln -sf "$(realpath config/.hushlogin)" "$HOME"
ln -sf "$(realpath config/zsh/.zshenv)" "$HOME"

for from in config/*
do
  from_fullpath=$(realpath "$from")
  to_fullpath="$HOME/.$from"

  echo "$from_fullpath"
  echo "$to_fullpath"

  if ! [ -e "$to_fullpath" ]; then
    ln -sf "$from_fullpath" "$to_fullpath"
  fi
done
