# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

# bash utils
alias ll='ls -al'
alias del-merged-branch="git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %"
alias gq='cd $(ghq list -p | peco)'

# peco history
peco-select-history() {
    BUFFER=$(fc -lnr 1 | sed 's/^[[:space:]]*//' | awk '!seen[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# docker
dockerit()
{
  docker pull "$@"
  docker run -it --rm "$@" /bin/bash
}

dockerita()
{
  docker pull "$@"
  docker run -it --rm "$@" /bin/ash
}

# k8s util
alias kc='kubectx | peco | xargs kubectx'
alias kn='kubens | peco | xargs kubens'

# anyenv (nodenv, goenv, ...)
eval "$(anyenv init -)"
