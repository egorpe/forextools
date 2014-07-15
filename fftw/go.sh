#!/bin/sh
uname -a
FFTWVERSION=3.3.4
rm -rf fftw-$FFTWVERSION *~ #* fftw-$FFTWVERSION.tar.gz
wget http://www.fftw.org/fftw-$FFTWVERSION.tar.gz
tar xvfz fftw-$FFTWVERSION.tar.gz 
cd fftw-$FFTWVERSION
./configure --with-our-malloc16 --with-windows-f77-mangling --enable-shared --enable-static --enable-threads --with-combined-threads --enable-sse2 -with-incoming-stack-boundary=2
make
make install
