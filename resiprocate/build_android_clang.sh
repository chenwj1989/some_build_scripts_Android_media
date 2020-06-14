#!/bin/bash

API_LEVEL=21

NDK=/home/test/android-ndk-r21b

TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

SYSROOT=$TOOLCHAIN/sysroot

OUTDIR=/home/test/resiprocate

OS=android

export LDFLAGS=" -pie"

PROJECTS="rutil resip/stack resip/dum"
export OPENSSL_HOME=/home/test/openssl-android

export CPPFLAGS="${CPPFLAGS} -I${OPENSSL_HOME}/include -fPIC"
export CXXFLAGS="${CXXFLAGS} -Os -fPIC"

function build 
{
./configure \
--prefix=$PREFIX \
--with-sysroot=$SYSROOT \
--enable-static \
--enable-shared \
--host=$HOST \
--enable-android \
--with-ssl \
$ADDI_CFLAGS

PROJECTS="rutil resip/stack resip/dum"

for proj in $PROJECTS ;
do
  make -C $proj clean
  make -C $proj -j4 install
done


#make clean
#make -j 4
#make install
echo "$ARCH build done"
}


#arm
ARCH=arm
PLATFORM=$ARCH-linux-androideabi
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH-linux-androideabi-
PREFIX=$OUTDIR/libs/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
export LDFLAGS="${LDFLAGS} -L${OPENSSL_HOME}/libs/armeabi-v7a"
ADDI_CFLAGS=""
build

#aarch64
PLATFORM=aarch64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android$API_LEVEL-
ARCH=aarch64
PREFIX=$OUTDIR/libs/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
export LDFLAGS="${LDFLAGS} -L${OPENSSL_HOME}/libs/arm64-v8a"

ADDI_CFLAGS=""
build

#x86
ARCH=i686
PLATFORM=$ARCH-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/$ARCH-linux-android$API_LEVEL-
PREFIX=$OUTDIR/libs/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
export LDFLAGS="${LDFLAGS} -L${OPENSSL_HOME}/libs/x86"
build

#x86_64
PLATFORM=x86_64-linux-android
ASM=$SYSROOT/usr/include/$PLATFORM
CROSS_PREFIX=$TOOLCHAIN/bin/$PLATFORM-
ANDROID_CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android$API_LEVEL-
ARCH=x86_64
PREFIX=$OUTDIR/libs/android/$ARCH
export CC=${ANDROID_CROSS_PREFIX}clang
export CXX=${ANDROID_CROSS_PREFIX}clang++
HOST=$ARCH-linux-androideabi
ADDI_CFLAGS=""
#build

