#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y install git tmux direnv ctags cmake \
  tree zsh curl yamllint host \
  silversearcher-ag ripgrep

echo "Initializing global git config..."
git config --global user.name "Duncan Rutland"
git config --global user.email "djrut@google.com"
git config --global status.submoduleSummary true

#Fuzzy wuzzy
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install