#!/usr/bin/env bash

sudo apt-get update && sudo apt-get install -qy gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get remove -qy --purge man-db
sudo apt-get update && sudo apt-get -qy install terraform \
  git tmux direnv ctags cmake \
  tree zsh yamllint host dnsutils jq \
  silversearcher-ag ripgrep kubectl

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
# Install Vim plugins
vim +'PlugInstall --sync' +qall
