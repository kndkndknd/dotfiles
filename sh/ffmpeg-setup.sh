#!/bin/bash
printf "password: "
read password

echo "$password" | sudo -S apt-get update -qq && sudo apt-get -y install \
  autoconf automake build-essential cmake git-core libass-dev \
  libfreetype6-dev libtool pkg-config texinfo wget zlib1g-dev
sudo apt -y install nasm libx264-dev libnuma-dev libx265-dev libvpx-dev libfdk-aac-dev libmp3lame-dev libopus-dev libaom-dev \
 libogg-dev libvorbis-dev libtheora-dev
mkdir -p ~/ffmpeg_sources
cd ~/ffmpeg_sources && \
  git -C SVT-AV1 pull 2> /dev/null || git clone https://gitlab.com/AOMediaCodec/SVT-AV1.git && \
  mkdir -p SVT-AV1/build && \
  cd SVT-AV1/build && \
  cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_DEC=OFF -DBUILD_SHARED_LIBS=OFF .. && \
  make -j4 && \
  echo "$password" | sudo -S make install && \
  cd

cd ~/ffmpeg_sources/ && \
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && \
tar xjvf ffmpeg-snapshot.tar.bz2 && \
cd ffmpeg && \
  ./configure \
  --pkg-config-flags="--static" \
  --disable-ffplay \
  --extra-libs="-lpthread -lm" \
  --enable-gpl \
  --enable-libaom \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libsvtav1 \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libtheora \
  --enable-libx264 \
  --enable-libx265 \
  --enable-openssl \
  --enable-nonfree && \
make -j4 && \
echo "$password" | sudo -S make install && \
hash -r
