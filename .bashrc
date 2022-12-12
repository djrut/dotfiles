# TMUX settings {{{
[[ $TMUX = "" ]] && export TERM="xterm-256color"
# }}}
# Aliases {{{
alias ls='ls --color=auto'
alias grep='grep --color'
alias kc="kubectl"
alias gce="gcloud compute"
alias gae="gcloud app"
alias gke="gcloud container"
alias act="source activate"
alias gcca="gcloud config configurations activate"
alias gccl="gcloud config configurations list"
alias gssh="gcloud compute ssh"
alias kcx='kubectl config use-context'
alias kcl='kubectl config get-contexts'
alias kbug='kubectl run debug --rm -i --tty --image=nicolaka/netshoot'
alias glog='git --no-pager log --pretty=oneline --decorate -n16'
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'
# }}}
# FZF Settings {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!*.git"'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }}}
# Direnv settings {{{
# https://github.com/direnv/direnv
eval "$(direnv hook bash)"
# }}}
# Functions {{{
show_gcloud_config() {
  if [[ -n "${CLOUDSDK_ACTIVE_CONFIG_NAME}" ]]; then
    echo "[$CLOUDSDK_ACTIVE_CONFIG_NAME]"
  elif [[ -s ~/.config/gcloud/active_config ]]; then
    echo "[$(cat ~/.config/gcloud/active_config)]"
  fi
}
# fix for direnv not handling changes to PS1
# https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1
#
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

show_k8s_context() {
  k8s_current_context=$(kubectl config current-context 2> /dev/null)
  if [[ $? -eq 0 ]] ; then echo -e "[${k8s_current_context}]"; fi
}

show_git_branch() {
  git_branch=$(git rev-parse --abbrev-ref HEAD)
  if [[ $? -eq 0 ]] ; then echo -e "[${git_branch}]"; fi
}

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

function colorize_prompt() {
  if [ $? -eq 0 ]; then
    echo -n '\[\e[0;92m\]$'
  else
    echo -n '\[\e[0;91m\]$'
  fi
}
# }}}
# Autocompletion settings {{{
# Pyenv Settings
if [ -f $(pyenv root)/completions/pyenv.bash ]; then source "$(pyenv root)/completions/pyenv.bash"; fi
eval "$(pyenv init -)"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/djrut/google-cloud-sdk/path.bash.inc' ]; then . '/Users/djrut/google-cloud-sdk/path.bash.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/djrut/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/djrut/google-cloud-sdk/completion.bash.inc'; fi
# Autocomplete configuration for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion bash)
fi
# }}}
# Prompt settings {{{
PROMPT_DIRTRIM=3
PS1="\[\e[0;92m\]$(show_git_branch)\[\e[0;96m\][\w]\[\e[0m\]\[\e[0;92m\]$\[\e[0m\] "
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
