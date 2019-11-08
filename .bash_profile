if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# bash utils
alias ll='ls -al'
targzFunction()
{
  tar zcvf "$@"
}
alias targz=targzFunction
tarbz2Function()
{
  tar jcvf "$@"
}
alias tarbz2=tarbz2Function
alias del-merged-branch="git branch --merged | grep -vE '^\*|master$|develop$' | xargs -I % git branch -d %"
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

# anyenv
eval "$(anyenv init -)"

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# aws
complete -C aws_completer aws

# peco history
peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
bind -x '"\C-r": peco-select-history'
