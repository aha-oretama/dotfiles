# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

# Move to top of the line by control + a
bindkey -e

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

# claude
alias ccd='claude --dangerously-skip-permissions'

# tailscale
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

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

# git worktree
wa() {
  if [ $# -eq 0 ]; then
    echo "Usage: wa <branch-name>"
    return 1
  fi

  local branch_name="$1"
  local worktree_dir=../"$(basename $(pwd))-${1}"

  # Try local branch first, then remote
  if git show-ref --verify --quiet refs/heads/"$branch_name"; then
    git worktree add "$worktree_dir" "$branch_name"
  elif git show-ref --verify --quiet refs/remotes/origin/"$branch_name"; then
    git worktree add "$worktree_dir" "origin/$branch_name"
  else
    git worktree add "$worktree_dir" -b "$branch_name"
  fi
}

select_worktree() {
  local tree=$(git worktree list | peco --query "$LBUFFER")
  if [ -n "$tree" ]; then
    BUFFER="cd `echo $tree | awk '{ print $1 }'`"
    zle accept-line
  fi
}
zle -N select_worktree
bindkey "^w" select_worktree

wr() {
  local selected_worktree
  selected_worktree=$(git worktree list | grep -v "(bare)" | tail -n +2 | peco --prompt="Remove worktree> ")

  if [ -n "$selected_worktree" ]; then
    local worktree_path=$(echo "$selected_worktree" | awk '{print $1}')
    echo "Removing worktree: $worktree_path"
    git worktree remove "$worktree_path"
  fi
}

# anyenv (nodenv, goenv, ...)
eval "$(anyenv init -)"

# direnv
eval "$(direnv hook zsh)"
export EDITOR='vim'

# Ref. https://stackoverflow.com/questions/51504367/gpg-agent-forwarding-inappropriate-ioctl-for-device
export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# gcloud
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
