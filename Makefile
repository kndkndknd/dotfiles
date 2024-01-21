# cf. https://zenn.dev/tsukuboshi/articles/6e82aef942d9af
# usage: make link etc...

# Do everything.
all: init link defaults brew

# Set macOS initial preference.
initmac:
	scripts/initmac.sh

# Link dotfiles.
link:
	scripts/link.sh
linkmac:
	scripts/linkmac.sh

# Set macOS system preferences.
defaults:
	scripts/defaults.sh

# Install macOS applications.
brew:
	scripts/brew.sh