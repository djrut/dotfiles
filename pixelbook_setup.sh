#!/usr/bin/env bash
sudo apt-get update
sudo apt-get -y install openssh-server vim-nox git tmux direnv ctags cmake \
  tree zsh curl default-jre default-jdk python3 python3-pip python3-dev \
  python python-pip python-dev golang yamllint helm maven host parallel \
  silversearcher-ag

# # Install Drive CLI
# sudo apt-add-repository 'deb http://shaggytwodope.github.io/repo ./' && \
#    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7086E9CC7EC3233B && \
#    apt-key update && \
#    apt-get update && \
#    apt-get install drive

# Create ssh key
# ssh-keygen
# cat .ssh/id_rsa.pub > .ssh/authorized_keys
# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Initializing global git config..."
git config --global user.name "Duncan Rutland"
git config --global user.email "djrut@google.com"
git config --global status.submoduleSummary true

# Pull down dotfiles 
echo "Pulling down dotfiles..."
cd && git init && \
	git remote add origin https://github.com/djrut/dotfiles.git && \
	git pull origin master

# tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Anaconda
curl -O https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh && \
  bash Anaconda3-5.0.1-Linux-x86_64.sh 

# gcloud SDK
curl https://sdk.cloud.google.com | bash

# Powerline fonts - follow instructions https://github.com/wernight/powerline-web-fonts
# term_.prefs_.set('font-family', '"DejaVu Sans Mono", monospace');
# term_.prefs_.set('user-css', 'https://cdn.rawgit.com/wernight/powerline-web-fonts/e4d967ca4f95d9fa0cf1d51afed2e5a5927d759e/PowerlineFonts.css');
