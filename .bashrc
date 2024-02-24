# TMUX settings {{{
[[ $TMUX = "" ]] && export TERM="xterm-256color"
# }}}
# Aliases {{{
alias ls='ls --color=auto'
alias grep='grep --color'
alias k="kubectl"
alias gce="gcloud compute"
alias gae="gcloud app"
alias gke="gcloud container"
alias act="source activate"
alias gcca="gcloud config configurations activate"
alias gccl="gcloud config configurations list"
alias gssh="gcloud compute ssh"
alias kcx='kubectl config use-context'
alias kcl='kubectl config get-contexts'
alias kbug='kubectl run debug --rm -i --tty --image=nicolaka/netshoot --privileged=false
alias glog='git --no-pager log --pretty=oneline --decorate -n32'
alias gdiff='git difftool'
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'
alias gss='git status -s'
alias gcmsg='git commit -m'
alias ptp='ptpython'
alias tree='tree -C'
alias top='bpytop'
# }}}
# FZF Settings {{{
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --glob "!*.git"'
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
[ -f $HOME/.fzf/shell/completion.bash ] && source $HOME/.fzf/shell/completion.bash
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
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # echo "($(basename $VIRTUAL_ENV))"
    echo "[V]"
  fi
}

function prompt_command() { 
    last_status=$?

    BGREEN="\[\e[0;92m\]"
    BCYAN="\[\e[0;96m\]"
    BRED="\[\e[0;31m\]"
    BHGREEN="\[\e[1;92m\]"
    BHCYAN="\[\e[1;96m\]"
    BHRED="\[\e[1;91m\]"
    RESTORE="\[\e[0m\]" #0m restores to the terminal's default colour

    if [ $last_status -eq 0 ];
    then
      STATUS_PROMPT="${BGREEN}$"
    else
      STATUS_PROMPT="${HRED}$"
    fi

    git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ $? -eq 0 ]] ; then
      if [ "${#git_branch}" -gt 32 ]; then
        GIT_BRANCH="[${git_branch:0:29}...]"
      else
        GIT_BRANCH="[${git_branch}]"
      fi
    else
      GIT_BRANCH=""
    fi
    VENV="$(show_virtual_env)"
    PS1="\u@\h:${BGREEN}${GIT_BRANCH}${BCYAN}[\w]${BHRED}${VENV}${STATUS_PROMPT}${RESTORE} "
    history -a
}

show_k8s_context() {
  k8s_current_context=$(kubectl config current-context 2> /dev/null)
  if [[ $? -eq 0 ]] ; then echo -e "[${k8s_current_context}]"; fi
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

function preview() {
  find . -name "$1" 2> /dev/null|fzf --preview="bat --color=always {}"
}

[[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]] && \
  source /opt/homebrew/etc/profile.d/bash_completion.sh

if [ -f $HOME/google-cloud-sdk/path.bash.inc ]; then 
  source $HOME/google-cloud-sdk/path.bash.inc; fi

if [ -f $HOME/google-cloud-sdk/completion.bash.inc ]; then
  source $HOME/google-cloud-sdk/completion.bash.inc; fi

if [ -f $HOME/git-completion.bash ]; then
    source $HOME/git-completion.bash
fi
# }}}
# Prompt settings {{{
PROMPT_COMMAND=prompt_command
PROMPT_DIRTRIM=3
# }}}
# direnv settings {{{
command -v direnv > /dev/null && eval "$(direnv hook bash)"
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
