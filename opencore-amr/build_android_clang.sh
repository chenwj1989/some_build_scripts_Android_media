#!/bin/bash

API_LEVEL=21

NDK=/home/test/android-ndk-r21b

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

SYSROOT=$TOOLCHAIN/sysroot

OUTDIR=/home/test

OS=android

export LDFLAGS=" -pie"

function build 
{
./configure \
--prefix=$PREFIX \
--with-sysroot=$SYSROOT \
--enable-static \
--enable-shared \
--host=$HOST \
--with-pic \
--enable-static \
--disable-shared \
--disable-fast-install \
--disable-maintainer-mode \
$ADDI_CFLAGS
	
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
PREFIX=$OUTDIR/opencore_amr_out/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
build

#aarch64
PLATFORM=aarch64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android$API_LEVEL-
ARCH=aarch64
PREFIX=$OUTDIR/opencore_amr_out/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
build

#x86
ARCH=i686
PLATFORM=$ARCH-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH-linux-android$API_LEVEL-
PREFIX=$OUTDIR/opencore_amr_out/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
build

#x86_64
PLATFORM=x86_64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android$API_LEVEL-
ARCH=x86_64
PREFIX=$OUTDIR/opencore_amr_out/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
build

