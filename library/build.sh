#!/bin/sh

rm -rf build
mkdir build
cd build

echo ''
echo ======== CONFIGURE ========
cmake ..

echo ''
echo ======== BUILD ========
cmake --build . --config Release

echo ''
echo ======== INSTALL ========
cmake --build . --config Release --target install