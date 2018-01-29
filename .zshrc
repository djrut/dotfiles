export DEFAULT_USER=djrut
# Path to your oh-my-zsh installation.
export ZSH=/Users/djrut/.oh-my-zsh

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
plugins=(git osx ruby node npm history brew colorize ssh-agent)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias cl="clear"
alias kc="kubectl"
alias gc="gcloud"
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

# The next line updates PATH for the Google Cloud SDK.
source '/Users/djrut/projects/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/djrut/projects/google-cloud-sdk/completion.zsh.inc'

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
export PS1="\$(show_conda_env)${PS1}"
