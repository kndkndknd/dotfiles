#!/bin/bash

if [ $# -lt 3 ]; then
  echo Error: Missing arguments
  echo "./ubuntu-setup.sh [Git user name] [Git user email] [Reboot at the end(y/n)]"
  exit
fi

GIT_USERNAME=$1
GIT_USEREMAIL=$2

echo "Git User Name         : $1"
echo "Git User Email        : $2"
echo "Reboot at the end(y/n): $3"

read "yn?ok? (y/N): "
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

# install minimal libraries
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install -y git curl

# install for python, asdf
sudo apt-get install -y gcc \
  build-essential \
  libffi-dev \
  libssl-dev \
  zlib1g-dev \
  liblzma-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libopencv-dev \
  tk-dev \
  git \
  curl \
  dirmngr gpg gawk

# git config
git config --global user.name $GIT_USERNAME
git config --global user.email $GIT_USEREMAIL
git config --global init.defaultBranch main
git config --global --add safe.directory "*"

# vs code
curl -L "https://go.microsoft.com/fwlink/?LinkID=760868" -o vscode.deb
sudo apt-get install -y ./vscode.deb && rm ./vscode.deb

# chrome
# Install Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ./google-chrome-stable_current_amd64.deb && rm ./google-chrome-stable_current_amd64.deb

# rust (default toolchain)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# docker
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
# Use docker command without sudo
sudo groupadd docker
sudo usermod -aG docker $USER

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
$HOME/.asdf/bin/asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
$HOME/.asdf/bin/asdf plugin add python

# copy from dotfiles
set -ue

helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

link_to_homedir() {
  command echo "backup old dotfiles..."
  if [ ! -d "$HOME/.dotbackup" ];then
    command echo "$HOME/.dotbackup not found. Auto Make it"
    command mkdir "$HOME/.dotbackup"
  fi

  local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dotdir=$(dirname ${script_dir})
  if [[ "$HOME" != "$dotdir" ]];then
    for f in $dotdir/.??*; do
      [[ `basename $f` == ".git" ]] && continue
      if [[ -L "$HOME/`basename $f`" ]];then
        command rm -f "$HOME/`basename $f`"
      fi
      if [[ -e "$HOME/`basename $f`" ]];then
        command mv "$HOME/`basename $f`" "$HOME/.dotbackup"
      fi
      command ln -snf $f $HOME
    done
  else
    command echo "same install src dest"
  fi
}

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

link_to_homedir

# reboot
if [ $3 = "y" ] ; then
  sudo reboot
else
  echo "\n\nfinished!!"
fi