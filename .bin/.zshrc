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
