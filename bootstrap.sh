#!/usr/bin/env bash
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
  if [[ "$OSTYPE" == "linux"* ]]; then
    sudo apt-get -qy update && \
    sudo apt-get -qy install gnupg software-properties-common curl && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    sudo apt-get -qy remove -qy --purge man-db && \
    sudo apt-get -qy update && sudo apt-get -qy install \
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
      silversearcher-ag ripgrep kubectl && success || failure
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    xcode-select -v || xcode-select --install && \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    brew install --quiet $(cat brew.txt) && success || failure
  else
    failure
    echo "ERROR: Unsupported OS type: ${OSTYPE}"
    exit 1
  fi
}
# }}}
# Function: git_config {{{
function git_config {
  h1 "Initializing global git config..."
  git config --global user.name "Duncan Rutland" && \
  git config --global user.email "rutland.duncan@heb.com" && \
  git config --global status.submoduleSummary true && \
  git config --global core.excludesFile '~/.gitignore_global' \
  git config --global --add --bool push.autoSetupRemote true \
  git config --global init.defaultBranch main && success || failure
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

  cd && git init && \
    git remote add origin https://github.com/djrut/dotfiles.git && \
    git pull --quiet origin master && success || failure
}
# }}}
# Function: install_fzf {{{
function install_fzf {
  h1 "Installing fuzzy-find..."

  if [ -d .fzf ]; then
    echo "ERROR: .fzf directory already exists... unable to install."
    failure
  else
    git clone --quiet --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all && success || failure
  fi
}
# }}}
# Function: install_pyenv {{{
function install_pyenv {
  h1 "Installing pyenv and python..."

  if [ -d .pyenv ]; then
    echo "WARNING: .pyenv directory already exists... skipping install."
    failure
  else
    curl -sSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash && \
    PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION} && \
    export PATH="$(pyenv root)/shims:$PATH" && success || failure
  fi
}
# }}}
# Function: install_tmux_plugin_manager {{{
function install_tmux_plugin_manager {
  h1 "Installing TMUX Plugin Manager..."
  if [ -d ~/.tmux/plugins/tpm ]; then
    echo "WARNING: ~/.tmux/plugins/tpm directory already exists... skipping install."
    failure
  else
    git clone --quiet https://github.com/tmux-plugins/tpm \
      ~/.tmux/plugins/tpm && success && \
    ~/.tmux/plugins/tpm/bin/install_plugins && success || failure
  fi
}
# }}}
# Function: install_vim_plugins {{{
function install_vim_plugins {
  h1 "Installing Vim plugins..."
  vim +'PlugInstall --sync' +qall && success || failure
}
# }}}
# Function: install_gcloud {{{
function install_gcloud {
  h1 "Installing gcloud..."
  if [ -d ~/.config/gcloud ]; then
    echo "WARNING: ~/.config/gcloud directory already exists... skipping install."
    failure
  else
    curl -sSL https://sdk.cloud.google.com | bash && success || failure
  fi
}
# }}}
# Function: install_git_completion {{{
function install_git_completion {
  h1 "Installing git-completion..."
  if [ -f ~/.git-completion.bash ]; then
    echo "WARNING: ~/.git-completion.bash file already exists... skipping install."
    failure
  else
    curl -sSL https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash && success || failure
  fi
}
# }}}
# Entrypoint  {{{
main "$@" #>> ${DEBUG_LOG} 2>&1

if (( failflag != 0 )); then
  echo "WARNING! One or more steps failed to execute properly. Check the debug log at ${DEBUG_LOG} for more details."
fi
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
