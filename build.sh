#!/bin/sh

# Clean up and make build + out dir
rm -rf build
mkdir build

rm -rf out
mkdir out

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