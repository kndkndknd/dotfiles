#!/bin/bash

# スクリプトが途中でエラーになった場合は停止する
set -e

printf "password: "
read password

echo "$password" | sudo -S apt-get update -qq && sudo apt-get -y install \
  wget \
  build-essential \
  autoconf \
  automake \
  cmake \
  git-core \
  libass-dev \
  libfreetype6-dev \
  libgnutls28-dev \
  libmp3lame-dev \
  libsdl2-dev \
  libtool \
  libva-dev \
  libvdpau-dev \
  libvorbis-dev \
  libxcb1-dev \
  libxcb-shm0-dev \
  libxcb-xfixes0-dev \
  meson \
  ninja-build \
  pkg-config \
  texinfo \
  yasm \
  zlib1g-dev
sudo apt -y install nasm \
	libx264-dev \
	libx265-dev libnuma-dev \
	libvpx-dev \
	libfdk-aac-dev \
	libopus-dev \
	libdav1d-dev
mkdir -p ~/src/ffmpeg_sources
mkdir -p ~/src/ffmpeg_build

# libaom
echo "install libaom"
cd ~/src/ffmpeg_sources && \
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom && \
mkdir -p aom_build && \
cd aom_build && \
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/src/ffmpeg_build" -DENABLE_TESTS=OFF -DENABLE_NASM=on ../aom && \
make -j4 && \
echo "$password" | sudo -S make install
echo "install libaom done"

# libsvtav1
echo "install libsvtav1"
cd ~/src/ffmpeg_sources && \
git -C SVT-AV1 pull 2> /dev/null || git clone https://gitlab.com/AOMediaCodec/SVT-AV1.git && \
mkdir -p SVT-AV1/build && \
cd SVT-AV1/build && \
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/src/ffmpeg_build" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF .. && \
make -j4 && \
echo "$password" | sudo -S make install
echo "install libsvtav1 done"

# libvmaf
echo "install libvmaf"
cd ~/src/ffmpeg_sources && \
wget https://github.com/Netflix/vmaf/archive/v2.3.1.tar.gz && \
tar xvf v2.3.1.tar.gz && \
mkdir -p vmaf-2.3.1/libvmaf/build &&\
cd vmaf-2.3.1/libvmaf/build && \
meson setup -Denable_tests=false -Denable_docs=false --buildtype=release --default-library=static .. --prefix "$HOME/src/ffmpeg_build" --libdir="$HOME/src/ffmpeg_build/lib" && \
ninja && \
ninja install
echo "install libvmaf done"

# ffmpeg
echo "install ffmpeg"
cd ~/src/ffmpeg_sources && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
PKG_CONFIG_PATH="$HOME/src/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/src/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/src/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/src/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --ld="g++" \
  --enable-gpl \
  --enable-gnutls \
  --enable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libsvtav1 \
  --enable-libdav1d \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree && \
make -j4 && \
echo "$password" | sudo -S make install &&\
hash -r
echo "install ffmpeg done"
