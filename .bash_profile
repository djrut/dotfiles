export PATH=/usr/local/git/current/bin:/usr/local/opt/python/libexec/bin
export PATH=/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
export PATH=/usr/local/bin:/usr/local/opt/gnu-sed/libexec/gnubin:${HOME}/google-cloud-sdk/bin:$PATH
export PATH=${HOME}/bin:/opt/homebrew/bin:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
export DEFAULT_USER=djrut
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!*.git"'

[[ $TMUX = "" ]] && export TERM="xterm-256color"

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
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Autocomplete configuration for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Autocomplete configuration for helm
if [ $commands[helm] ]; then
  source <(helm completion zsh)
fi

# fix for direnv not handling changes to PS1
# https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1
#
setopt PROMPT_SUBST

show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1

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
# PS1='$(show_gcloud_config)'$PS1

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/djrut/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/djrut/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/djrut/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/djrut/google-cloud-sdk/completion.zsh.inc'; fi
