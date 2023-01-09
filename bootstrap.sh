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
: ${PYTHON_VERSION:=3.11.1}
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
  install_pyenv
  install_tmux_plugin_manager
  install_vim_plugins
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
  sudo apt-get -qy update >> ${DEBUG_LOG} 2>&1 && \
  sudo apt-get -qy install gnupg software-properties-common curl >> ${DEBUG_LOG} 2>&1 && \
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - >> ${DEBUG_LOG} 2>&1 && \
  sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" >> ${DEBUG_LOG} 2>&1 && \
  sudo apt-get -qy remove -qy --purge man-db >> ${DEBUG_LOG} 2>&1 && \
  sudo apt-get -qy update >> ${DEBUG_LOG} 2>&1 && sudo apt-get -qy install \
    build-essential gcc pkg-config make \
    zlib1g zlib1g-dev libffi-dev \
    libssl-dev libbz2-dev libreadline-dev \
    libsqlite3-dev liblzma-dev \
    python-dev python-setuptools \
    libbz2-dev libreadline-dev libsqlite3-dev liblzma-dev \
    libncursesw5-dev libgdbm-dev libc6-dev \
    libsqlite3-dev tk-dev libssl-dev openssl \
    google-cloud-sdk-gke-gcloud-auth-plugin \
    git tmux direnv exuberant-ctags cmake \
    tree zsh yamllint host dnsutils jq \
    silversearcher-ag ripgrep kubectl >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: git_config {{{
function git_config {
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

  if [ -d .git ]; then
    failure
    echo "FATAL: .git directory already exists... aborting!"
    exit 1
  fi

  for dotfile in .bashrc .profile .zsh .tmux.conf .vimrc .bash_profile; do
    [ -f ${dotfile} ] && mv ${dotfile} ${dotfile}.bak
  done

  [ -d .git ] && mv .git .git.bak

  cd && git init >> ${DEBUG_LOG} 2>&1 && \
    git remote add origin https://github.com/djrut/dotfiles.git >> ${DEBUG_LOG} 2>&1 && \
    git pull --quiet origin master >> ${DEBUG_LOG} 2>&1 && success || failure
}
# }}}
# Function: install_fzf {{{
function install_fzf {
  h1 "Installing fuzzy-find..."

  if [ -d .fzf ]; then
    echo "ERROR: .fzf directory already exists... unable to install." >> ${DEBUG_LOG} 2>&1
    failure
  else
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >> ${DEBUG_LOG} 2>&1 && \
    ~/.fzf/install --all >> ${DEBUG_LOG} 2>&1 && success || failure
  fi
}
# }}}
# Function: install_pyenv {{{
function install_pyenv {
  h1 "Installing pyenv and python..."

  if [ -d .pyenv ]; then
    echo "WARNING: .pyenv directory already exists... skipping install." >> ${DEBUG_LOG} 2>&1
    failure
  else
    curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash >> ${DEBUG_LOG} 2>&1 && \
    PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION} >> ${DEBUG_LOG} 2>&1 && \
    pyenv global ${PYTHON_VERSION} >> ${DEBUG_LOG} 2>&1 && \
    export PATH="$(pyenv root)/shims:$PATH"  >> ${DEBUG_LOG} 2>&1 && success || failure
  fi
}
# }}}
# Function: install_tmux_plugin_manager {{{
function install_tmux_plugin_manager {
  h1 "Installing TMUX Plugin Manager..."
  if [ -d ~/.tmux/plugins/tpm ]; then
    echo "WARNING: ~/.tmux/plugins/tpm directory already exists... skipping install." >> ${DEBUG_LOG} 2>&1
    failure
  else
    git clone --quiet https://github.com/tmux-plugins/tpm \
      ~/.tmux/plugins/tpm >> ${DEBUG_LOG} 2>&1 && success || failure
  fi
}
# }}}
# Function: install_vim_plugins {{{
function install_vim_plugins {
  h1 "Installing Vim plugins..."
  vim +'PlugInstall --sync' +qall && success || failure
}
# }}}
# Entrypoint  {{{
main "$@"

if (( failflag != 0 )); then
  echo "WARNING! One or more steps failed to execute properly. Check the debug log at ${DEBUG_LOG} for more details."
fi
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
