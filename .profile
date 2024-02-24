if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
  export PATH=$HOME/bin:$HOME/scripts:$HOME/.fzf/bin:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export JAVA_HOME=/Library/Java/Home
  export PYTHON_CONFIGURE_OPTS="--enable-framework"
  export PATH=/usr/local/git/current/bin:/usr/local/opt/python/libexec/bin
  export PATH=/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
  export PATH=/usr/local/bin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH
  export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:${HOME}/.krew/bin:$PATH
  export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"
  export PATH=$HOME/google-cloud-sdk/bin:$HOME/.cargo/bin:$PATH
  export PATH=$HOME/bin:$HOME/scripts:$HOME/.fzf/bin:$PATH
fi

shopt -s histappend
export HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTFILESIZE=
export HISTSIZE=
export DIRENV_WARN_TIMEOUT=10s
export SYSTEM_VERSION_COMPAT=1
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export BAT_THEME=Coldark-Dark
