#!/usr/bin/env bash

brew install $(cat brew.txt)

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

# gcloud SDK
curl https://sdk.cloud.google.com | bash

# fzf

# Vim

# Powerline fonts - follow instructions https://github.com/wernight/powerline-web-fonts
# term_.prefs_.set('font-family', '"DejaVu Sans Mono", monospace');
# term_.prefs_.set('user-css', 'https://cdn.rawgit.com/wernight/powerline-web-fonts/e4d967ca4f95d9fa0cf1d51afed2e5a5927d759e/PowerlineFonts.css');
