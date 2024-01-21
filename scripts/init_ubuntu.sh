#!/bin/bash

# スクリプトが途中でエラーになった場合は停止する
set -e

# 必要なソフトウェアの更新とインストール
sudo apt update
sudo apt install -y curl git zsh wget build-essential 

# python関連パッケージ
sudo apt install libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libopencv-dev tk-dev

# asdfのインストール
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
echo '. $HOME/.asdf/asdf.sh' >> ~/.zshrc
echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
source ~/.zshrc

# asdfを使用してPythonとNode.jsをインストール
asdf plugin-add python
asdf install python latest
asdf global python $(asdf list python | tail -n 1)

asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs $(asdf list nodejs | tail -n 1)

# Rustのインストール
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ryeのインストール
curl -sSf https://rye-up.com/get | bash

# neovim install
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
sudo mv squashfs-root /nvim
sudo ln -s /nvim/AppRun /usr/bin/nvim

# ユーザーのデフォルトシェルをzshに変更
chsh -s $(which zsh)

echo "インストールが完了しました。再起動または新しいターミナルセッションを開始してください。"
