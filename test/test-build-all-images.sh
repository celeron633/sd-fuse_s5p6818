#!/bin/bash
set -eux

HTTP_SERVER=112.124.9.243

# hack for me
[ -f /etc/friendlyarm ] && source /etc/friendlyarm $(basename $(builtin cd ..; pwd))

# clean
mkdir -p tmp
sudo rm -rf tmp/*

cd tmp
git clone ../../.git -b master sd-fuse_s5p6818
cd sd-fuse_s5p6818

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/friendlycore-images.tgz
tar xzf friendlycore-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/friendlycore-arm64-images.tgz
tar xzf friendlycore-arm64-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/ubuntu-noble-core-images.tgz
tar xzf ubuntu-noble-core-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/ubuntu-noble-core-arm64-images.tgz
tar xzf ubuntu-noble-core-arm64-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/friendlywrt-images.tgz
tar xzf friendlywrt-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/lubuntu-desktop-images.tgz
tar xzf lubuntu-desktop-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/android-nougat-images.tgz
tar xzf android-nougat-images.tgz

wget --no-proxy http://${HTTP_SERVER}/dvdfiles/S5P6818/images-for-eflasher/emmc-flasher-images.tgz
tar xzf emmc-flasher-images.tgz

sudo ./mk-sd-image.sh friendlycore
sudo ./mk-emmc-image.sh friendlycore

sudo ./mk-sd-image.sh friendlycore-arm64
sudo ./mk-emmc-image.sh friendlycore-arm64

sudo ./mk-sd-image.sh ubuntu-noble-core
sudo ./mk-emmc-image.sh ubuntu-noble-core

sudo ./mk-sd-image.sh ubuntu-noble-core-arm64
sudo ./mk-emmc-image.sh ubuntu-noble-core-arm64

sudo ./mk-sd-image.sh friendlywrt
sudo ./mk-emmc-image.sh friendlywrt

# sudo ./mk-sd-image.sh android7
sudo ./mk-emmc-image.sh android7

sudo ./mk-sd-image.sh lubuntu
sudo ./mk-emmc-image.sh lubuntu

echo "done."
