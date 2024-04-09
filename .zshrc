# Functions {{{
function current_git_branch() {
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
    echo $GIT_BRANCH
}
# }}}
# General Settings {{{
export SYSTEM_VERSION_COMPAT=1
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export BAT_THEME=Coldark-Dark
export JAVA_HOME=/Library/Java/Home
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-shared"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--enable-framework"
# }}}
# Path {{{
  export PATH=/usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:$PATH
  export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:${HOME}/.krew/bin:$PATH
  export PATH=$HOME/google-cloud-sdk/bin:$HOME/.cargo/bin:$PATH
  export PATH=$HOME/bin:$HOME/scripts:$HOME/.fzf/bin:$PATH
fi
# }}}
# PROMPT settings {{{
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
PROMPT="%n@%m:%F{014}[%d]%F{green}$(current_git_branch)%(?.%f$.%F{red}$) %f"
# }}}
# DIRENV settings {{{
export DIRENV_WARN_TIMEOUT=10s
command -v direnv > /dev/null && eval "$(direnv hook zsh)"
# }}}
# FZF Settings {{{
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --follow --glob "!*.git"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $HOME/.fzf/shell/completion.zsh ] && source $HOME/.fzf/shell/completion.zsh
# }}}
# TMUX settings {{{
[[ $TMUX = "" ]] && export TERM="xterm-256color"
# }}}
# PYENV settings {{{
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
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
alias kbug='kubectl run debug --rm -i --tty --image=nicolaka/netshoot --privileged=false'
alias glog='git --no-pager log --pretty=oneline --decorate -n32'
alias gdiff='git difftool'
alias gcurl='curl --header "Authorization: Bearer $(gcloud auth print-identity-token)"'
alias gss='git status -s'
alias gcmsg='git commit -m'
alias ptp='ptpython'
alias tree='tree -C'
alias top='bpytop'
# }}}
# Metadata {{{
# vim:foldmethod=marker:foldlevel=0
# }}}
