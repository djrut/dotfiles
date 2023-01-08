#!/usr/bin/env bash
# License {{{
# Copyright [2022] [Google]

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# }}}
# Globals {{{
: ${PYTHON_VERSION}:="3.11.1"
: ${DEBUG_LOG:=bootstrap-debug-$(date +%s)}
# }}}
# Function: main {{{
function main {
  failflag=0
  install_packages
  git_config
  install_dotfiles
  install_fzf
  source ~/.bash_profile
}
# }}}
# Utility functions {{{
function h1 {
   printf "\u25a3 ${1}"
}

function h2 {
   printf "\t\u25a1 ${1}"
}

function h3 {
   printf "\t\t\u2023 ${1}"
}

function failure {
  printf " \u274c\n"
  failflag=1
}

function success {
  printf " \u2705\n"
}

function join_by {
  local IFS="$1"
  shift
  echo "$*"
}
# }}}
# Function: install_packages {{{ 
function install_packages {
  h1 "Installing OS packages..."
  sudo apt-get update && sudo apt-get install -qy gnupg software-properties-common curl && \
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  sudo apt-get remove -qy --purge man-db && \
  sudo apt-get update && sudo apt-get -qy install terraform \
    git tmux direnv ctags cmake \
    tree zsh yamllint host dnsutils jq \
    silversearcher-ag ripgrep kubectl \
    build-essential zlib1g-dev libffi-dev \
    libssl-dev libbz2-dev libreadline-dev \
    libsqlite3-dev liblzma-dev >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: git_config {{{
function git_config {n
  h1 "Initializing global git config..."
  git config --global user.name "Duncan Rutland" && \
  git config --global user.email "djrut@google.com" && \
  git config --global status.submoduleSummary true >> ${DEBUG_LOG} 2>&1 && \
  success || failure
}
# }}}
# Function: install_dotfiles {{{
function install_dotfiles {
  h1 "Installing dotfiles..."

  mv .bashrc .bashrc.bak
  mv .profile .profile.bak
  mv .zshrc .zshrc.bak

  cd && git init && \
    git remote add origin https://github.com/djrut/dotfiles.git && \
    git pull --quiet origin master >> ${DEBUG_LOG} 2>&1 && success || failure
  }
# }}}
# Function: install_fzf {{{
function install_fzf {
  h1 "Installing fuzzy-find..."
  git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
  ~/.fzf/install --all >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: install_pyenv {{{
function install_pyenv {
  h1 "Installing pyenv and python..."
  curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && \
  PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION} && \
  pyenv global ${PYTHON_VERSION} && \
  export PATH="$(pyenv root)/shims:$PATH"  >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: install_tmux_plugin_manager {{{
function install_tmux_plugin_manager {
  h1 "Installing TMUX Plugin Manager..."
  curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && \
  git clone --quiet https://github.com/tmux-plugins/tpm \
    ~/.tmux/plugins/tpm >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: install_vim_plugins {{{
function install_vim_plugins {
  h1 "Installing Vim plugins..."
  vim +'PlugInstall --sync' +qall >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Entrypoint  {{{
main "$@"

if (( failflag != 0 )); then
  echo "ERROR! One or more steps failed to execute properly. Check the debug log at ${DEBUG_LOG} for more details."
  exit 1
fi

exit
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
