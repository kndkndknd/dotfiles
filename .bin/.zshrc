# macOS
if [[ "$OSTYPE" == darwin* ]]; then
    # load Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Load asdf
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    # Haskell(tycalCycles)
    source ${HOME}/.ghcup/env
fi

# Linux(zsh)
if [[ "$OSTYPE" == linux* ]]; then
    # Load asdf
    . $HOME/.asdf/asdf.sh
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit && compinit
    # history
    export HISTFILE=${HOME}/.zsh_history
    export HISTSIZE=1000
    export SAVEHIST=100000
    setopt hist_ignore_dups
    setopt EXTENDED_HISTORY
fi

# Load rye
source "$HOME/.rye/env"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# alias
alias ci='code-insiders .'
alias nvimconfig='nvim ~/.config/nvim/init.lua'
alias v='nvim'
alias work='cd ~/Sync/work'
alias ide="~/sh/ide.sh"

# path
RPROMPT="%~"
