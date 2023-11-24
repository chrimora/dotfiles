#!/bin/bash

function linkdotfile {
  file="$1"
  mkdir -p ~/$(dirname "$file")
  ln -s ~/dotfiles/$file ~/$file
}

# Editors
linkdotfile .vimrc

linkdotfile .config/helix/config.toml
linkdotfile .config/helix/languages.toml
