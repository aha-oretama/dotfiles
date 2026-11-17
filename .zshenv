# History
export HISTSIZE=10000
export SAVEHIST=10000

## Go (GOROOT is managed by goenv)
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# GNU grep
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

# psql, mysql
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql/bin:$PATH"

# Machine-specific settings and secrets, kept out of this repository
[ -f "$HOME/.zshenv.local" ] && source "$HOME/.zshenv.local"
