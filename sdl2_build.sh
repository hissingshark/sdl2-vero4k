#!/bin/bash

# *************************************************
# Script to build SDL2 on the OSMC Vero 4K
# HissingShark 2017 -
# *************************************************

# remember whence we came
pushd .

# install typical building suite
sudo apt-get update
sudo apt-get install -y vero3-userland-dev-osmc build-essential git

# set flags useful to all of the builds on our Amlogic S905x based Vero 4K
export CFLAGS="-I/opt/vero3/include -L/opt/vero3/lib -O3 -march=armv8-a+crc -mtune=cortex-a53 -funsafe-math-optimizations"
export CPPFLAGS=$CFLAGS
export CXXFLAGS=$CFLAGS

# install specific packages for building  SDL2
sudo apt-get install -y libasound2-dev libdbus-1-dev libudev-dev

# pull a fork of SDL2 v.2.0.2 that includes MALI-fbdev support
# cd
# git clone https://github.com/mihailescu2m/libsdl2-2.0.2-dfsg1.git

# build/install SDL2 - a major dependancy of the project
#cd libsdl2-2.0.2-dfsg1

# scratch previous - the mali-fb support has been merged into the retropie maintained fork giving v2.07
cd
git clone https://github.com/RetroPie/SDL-mirror.git --branch mali-2.0.7
cd SDL-mirror
./configure --enable-video-mali
sudo make -j4
sudo make install

# aaaand we're back
popd
