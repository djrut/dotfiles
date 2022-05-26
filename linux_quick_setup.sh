#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -qy install git tmux direnv ctags cmake \
  tree zsh curl yamllint host dnsutils \
  silversearcher-ag ripgrep

echo "Initializing global git config..."
git config --global user.name "Duncan Rutland"
git config --global user.email "djrut@google.com"
git config --global status.submoduleSummary true

# Pull down dotfiles 
echo "Pulling down dotfiles..."
cd && git init && \
	git remote add origin https://github.com/djrut/dotfiles.git && \
	git pull origin master

#Fuzzy wuzzy
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

source ~/.bashrc
