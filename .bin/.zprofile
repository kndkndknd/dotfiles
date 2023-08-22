# load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Load rye
source "$HOME/.rye/env"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
