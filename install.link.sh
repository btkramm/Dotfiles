#!/bin/bash

for from in config/*
do
  from_fullpath=$(realpath "$from")
  to_fullpath="$HOME/.$from"

  if ! [ -e "$to_fullpath" ]; then
    ln -s "$from_fullpath" "$to_fullpath"
  fi
done
