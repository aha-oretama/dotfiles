# bash utils
alias ll='ls -al'
alias del-merged-branch="git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %"
alias gh='cd $(ghq list -p | peco)'
# peco history
peco-select-history() {
    BUFFER=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    CURSOR=$#BUFFER
    zle -R -c
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

# anyenv
eval "$(anyenv init -)"

# goenv
eval "$(goenv init -)"
