#!/bin/bash

# スクリプトが途中でエラーになった場合は停止する
set -e

# 必要なソフトウェアの更新とインストール
sudo apt update
sudo apt install -y curl git zsh wget build-essential 

# python関連パッケージ
sudo apt install libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libopencv-dev tk-dev

# miseのインストール
curl https://mise.run | sh
$HOME/.local/bin/mise use --global node@22
$HOME/.local/bin/mise use --global python@latest

# Rustのインストール
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# uvのインストール
curl -LsSf https://astral.sh/uv/install.sh | sh
$HOME/.local/bin/uv python install 3.9 3.10 3.13

# neovim install
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# oh-my-zshのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# プラグインのインストール
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Dockerのインストール
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker $USER
sudo gpasswd -a $USER docker

# ユーザーのデフォルトシェルをzshに変更
chsh -s $(which zsh)

echo "インストールが完了しました。再起動または新しいターミナルセッションを開始してください。"
