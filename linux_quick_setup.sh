#!/usr/bin/env bash
# Globals {{{
PYTHON_VERSION="3.11.1"
# }}}
# Install packages {{{
sudo apt-get update && sudo apt-get install -qy gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get remove -qy --purge man-db
sudo apt-get update && sudo apt-get -qy install terraform \
  git tmux direnv ctags cmake \
  tree zsh yamllint host dnsutils jq \
  silversearcher-ag ripgrep kubectl \
  build-essential zlib1g-dev libffi-dev \
  libssl-dev libbz2-dev libreadline-dev \
  libsqlite3-dev liblzma-dev
# }}}
# Global git config {{{
echo "Initializing global git config..."
git config --global user.name "Duncan Rutland"
git config --global user.email "djrut@google.com"
git config --global status.submoduleSummary true
# }}}
# Save original configuration files {{{
mv .bashrc .bashrc.bak
mv .profile .profile.bak
mv .zshrc .zshrc.bak
# }}}
# Pull down dotfiles {{{
echo "Pulling down dotfiles..."
cd && git init && \
	git remote add origin https://github.com/djrut/dotfiles.git && \
	git pull origin master
# }}}
# Install FZF {{{
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
# }}}
# Source new .bashrc {{{
source ~/.bash_profile
# }}}
# Install pyenv and Python {{{
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
# }}}
# Install TMUX plugin manager {{{
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# }}}
# Install Vim plugins {{{
vim +'PlugInstall --sync' +qall
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
