# macOS
if [[ "$OSTYPE" == darwin* ]]; then
    # load Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Load asdf
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    # Haskell(tycalCycles)
    source ${HOME}/.ghcup/env

    # pnpm
    export PNPM_HOME="/Users/knd/Library/pnpm"
    case ":$PATH:" in
      *":$PNPM_HOME:"*) ;;
      *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # pnpm end


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
    export HISTSIZE=100000
    export SAVEHIST=100000
    setopt hist_ignore_dups
    setopt EXTENDED_HISTORY

    SESSION_NAME=main
    if [[ -z "$TMUX" && -z "$STY" ]] && type tmux >/dev/null 2>&1; then
      option=""
      if tmux has-session -t ${SESSION_NAME}; then
        option="attach -t ${SESSION_NAME}"
      else
        option="new -s ${SESSION_NAME}"
      fi
      # tmux $option && exit
    fi

    # OSを判別して変数に格納
    if [[ -f /etc/os-release ]]; then
      source /etc/os-release
      case "$ID" in
        ubuntu)
          echo "Ubuntu detected"
          # Ubuntu向けの設定
          export PATH="$PATH:/path/to/ubuntu-specific"
          alias ll='ls -alF'
          ;;
        manjaro)
          echo "Manjaro detected"
          # Manjaro向けの設定
          export PATH="$PATH:/path/to/manjaro-specific"
          alias ll='ls -lh --color=auto'
          ;;
        *)
          echo "Unsupported OS: $ID"
          ;;
      esac
    else
      echo "OS information not found"
    fi
fi

# Load rye
source "$HOME/.rye/env"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# ffmpeg
export PATH="$HOME/src/ffmpeg_build/bin:$PATH"

# alias
alias ci='code-insiders .'
alias nvimconfig='nvim ~/.config/nvim/init.lua'
alias v='nvim'
alias work='cd ~/Sync/work'
alias ide="~/dotfiles/scripts/ide.sh"

# history
# HISTFILE=$HOME/.zsh_history
# SAVEHIST=100000
# HISTSIZE=100000

# path
RPROMPT="%~"
