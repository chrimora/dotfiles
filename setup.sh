#!/bin/bash

function linkdotfile {
  ln -s "~/dotfiles/$1" "~/$1"
}

# Editors
linkdotfile .vimrc

linkdotfile .config/helix/config.toml
linkdotfile .config/helix/languages.toml
