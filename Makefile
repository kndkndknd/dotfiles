# cf. https://zenn.dev/tsukuboshi/articles/6e82aef942d9af

# Do everything.
all: init link defaults brew

# Set macOS initial preference.
initmac:
	sh/initmac.sh

# Link dotfiles.
link:
	sh/link.sh

# Set macOS system preferences.
defaults:
	sh/defaults.sh

# Install macOS applications.
brew:
	sh/brew.sh