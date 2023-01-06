export PATH=/usr/local/git/current/bin:/usr/local/opt/python/libexec/bin
export PATH=/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/gnu-sed/libexec/gnubin:~/google-cloud-sdk/bin:$PATH
export PATH=$HOME/bin:/opt/homebrew/bin:$HOME/.fzf/bin:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
export DIRENV_WARN_TIMEOUT=10s
export JAVA_HOME=/Library/Java/Home
export SYSTEM_VERSION_COMPAT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv > /dev/null && export PATH="$(pyenv root)/shims:$PATH"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-framework"
fi
