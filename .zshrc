export DEFAULT_USER=djrut
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

[[ $TMUX = "" ]] && export TERM="xterm-256color"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history colorize ssh-agent)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias cl="clear"
alias kc="kubectl"
alias kcx="kubectl config use-context"
alias gce="gcloud compute"
alias gae="gcloud app"
alias gke="gcloud container"
alias gdd="gcloud deployment-manager"
alias act="source activate"
alias dact="source deactivate"
alias gcca="gcloud config configurations activate"
alias gccl="gcloud config configurations list"
alias gssh="gcloud compute ssh"
alias gis="gcloud iam service-accounts"
alias kcx='kubectl config use-context'
alias kcl='kubectl config get-contexts'
alias glog='git --no-pager log --pretty=oneline --decorate -n16'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Autocomplete configuration for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Autocomplete configuration for helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# fix for direnv not handling changes to PS1
# https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1
#
show_conda_env() {
  if [ -n "${CONDA_DEFAULT_ENV}" ]; then
    echo "(${CONDA_DEFAULT_ENV}) "
  fi
}

export -f show_conda_env > /dev/null 2>&1

show_gcloud_config() {
  if [[ -n "${CLOUDSDK_ACTIVE_CONFIG_NAME}" ]]; then
    echo "[$CLOUDSDK_ACTIVE_CONFIG_NAME]"
  elif [[ -s ~/.config/gcloud/active_config ]]; then
    echo "[$(cat ~/.config/gcloud/active_config)]"
  fi
}

show_k8s_context() {
  k8s_current_context=$(kubectl config current-context 2> /dev/null)
  if [[ $? -eq 0 ]] ; then echo -e "[${k8s_current_context}]"; fi
}

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

export -f show_virtual_env > /dev/null 2>&1
# PS1='$(show_gcloud_config)$(show_conda_env)$(show_k8s_context)'$PS1
PS1='$(show_gcloud_config)$(show_conda_env)'$PS1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then source '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then source '~/google-cloud-sdk/completion.zsh.inc'; fi

# Start vim with Obsession enabled unless Session already exists
function vim() {
  if test $# -gt 0; then
    env vim "$@"
  elif test -f Session.vim; then
    env vim -S
  else
    env vim -c Obsession
  fi
}

gcloud_staging () {
       gcloud config set api_endpoint_overrides/deploymentmanager https://www.googleapis.com/deploymentmanager/staging_v2/
       gcloud "$@"
       gcloud config unset api_endpoint_overrides/deploymentmanager
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/djrut/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/djrut/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/djrut/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/djrut/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

