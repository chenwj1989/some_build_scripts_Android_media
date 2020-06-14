#!/bin/bash

API_LEVEL=21

NDK=/home/test/android-ndk-r21b

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

SYSROOT=$TOOLCHAIN/sysroot

TMPDIR="./temp"

OS=android

EXTERNAL_PATH=/home/test

function build 
{
./configure \
--prefix=$PREFIX \
--enable-cross-compile \
--cross-prefix=$CROSS_PREFIX \
--target-os=$OS \
--arch=$ARCH \
--pkg-config=$(which pkg-config) \
--cc=${ANDROID_CROSS_PREFIX}clang \
--cxx=${ANDROID_CROSS_PREFIX}clang++ \
--disable-asm \
--disable-x86asm \
--disable-stripping \
--sysroot=$SYSROOT \
--fatal-warnings \
--enable-gpl \
--enable-version3 \
--enable-nonfree \
--disable-ffplay \
--disable-ffprobe \
--enable-pic \
--enable-jni \
--enable-shared \
--enable-protocol=file \
--enable-libfdk-aac  \
--enable-libx264   \
--enable-libopencore-amrnb \
--enable-libopencore-amrwb \
--enable-libopus \
--extra-cflags="-Os -fpic -I$ASM -isysroot $SYSROOTi $ADDI_CFLAGS" \
--extra-ldflags="$ADDI_LDFLAGS -pie -Wl,-lc -lm -ldl -L$EXTERNAL_LIBS"
make clean
make -j 4
make install
echo "$ARCH build done"
}


#arm
ARCH=arm
PLATFORM=$ARCH-linux-androideabi
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH-linux-androideabi-
PREFIX=./ffmpeg_out/android/$ARCH
ADDI_CFLAGS="-I$EXTERNAL_PATH/fdkaac_out/android/$ARCH/include -I$EXTERNAL_PATH/x264_out/android/$ARCH/include -I$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/include  -I$EXTERNAL_PATH/opus_out/android/$ARCH/include"
ADDI_LDFLAGS="-L$EXTERNAL_PATH/fdkaac_out/android/$ARCG/libs -L$EXTERNAL_PATH/x264_out/android/$ARCH/libs -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib  -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib"
build

#aarch64
PLATFORM=aarch64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android$API_LEVEL-
ARCH=aarch64
PREFIX=./ffmpeg_out/android/$ARCH
ADDI_CFLAGS="-I$EXTERNAL_PATH/fdkaac_out/android/$ARCH/include -I$EXTERNAL_PATH/x264_out/android/$ARCH/include -I$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/include  -I$EXTERNAL_PATH/opus_out/android/$ARCH/include"
ADDI_LDFLAGS="-L$EXTERNAL_PATH/fdkaac_out/android/$ARCG/libs -L$EXTERNAL_PATH/x264_out/android/$ARCH/libs -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib  -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib"
build

#x86
ARCH=i686
PLATFORM=$ARCH-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH-linux-android$API_LEVEL-
PREFIX=./ffmpeg_out/android/$ARCH
ADDI_CFLAGS="-I$EXTERNAL_PATH/fdkaac_out/android/$ARCH/include -I$EXTERNAL_PATH/x264_out/android/$ARCH/include -I$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/include  -I$EXTERNAL_PATH/opus_out/android/$ARCH/include"
ADDI_LDFLAGS="-L$EXTERNAL_PATH/fdkaac_out/android/$ARCG/libs -L$EXTERNAL_PATH/x264_out/android/$ARCH/libs -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib  -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib"
build

#x86_64
PLATFORM=x86_64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android$API_LEVEL-
ARCH=x86_64
PREFIX=./ffmpeg_out/android/$ARCH
ADDI_CFLAGS="-I$EXTERNAL_PATH/fdkaac_out/android/$ARCH/include -I$EXTERNAL_PATH/x264_out/android/$ARCH/include -I$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/include  -I$EXTERNAL_PATH/opus_out/android/$ARCH/include"
ADDI_LDFLAGS="-L$EXTERNAL_PATH/fdkaac_out/android/$ARCG/libs -L$EXTERNAL_PATH/x264_out/android/$ARCH/libs -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib  -L$EXTERNAL_PATH/opencore_amr_out/android/$ARCH/lib"
build

