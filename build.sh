#!/bin/sh

# Clean up and make build + out dir
rm -rf build
mkdir build

rm -rf out
mkdir out

mkdir out/untethered

# NPM install for Node script
cd modulesJson
npm install


cd ../build

# Clone repo
git clone https://github.com/GooseMod/Modules clone

# Use Node script to generate JSON and copy over minified JS files
node ../modulesJson/generate.mjs

# Copy _headers
cd ..

cp _headers out/_headers

# Copy latest inject.js to out (for untethered)
wget https://raw.githubusercontent.com/GooseMod/Injector/master/dist/index.js -O out/inject.js

# Copy latest untethered JS stuff to out (for untethered)
wget https://raw.githubusercontent.com/GooseMod/Untethered/master/src/untetheredInject.js -O out/untethered/untetheredInject.js
# wget https://raw.githubusercontent.com/GooseMod/Untethered/master/src/base.js -O out/untethered/base.js
