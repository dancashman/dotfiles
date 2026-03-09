#!/usr/bin/env bash

mkdir -p ~/.config/{zellij,alacritty,ghostty}

cp starship.toml ~/.config/starship.toml

ln -sf $(pwd)/hyper.js ~/.hyper.js
ln -sf $(pwd)/zsh/zshrc ~/.zshrc
ln -sf $(pwd)/nvim ~/.config/nvim
ln -sf $(pwd)/zellij.kdl ~/.config/zellij/config.kdl
ln -sf $(pwd)/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf $(pwd)/wezterm.lua ~/.wezterm.lua
ln -sf $(pwd)/aerospace.toml ~/.aerospace.toml
ln -sf $(pwd)/ghostty ~/.config/ghostty/config
