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

export PATH=$HOME/IdeaProjects/utilShells:$PATH

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# aws
complete -C aws_completer aws

