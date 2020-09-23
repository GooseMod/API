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

# Use Node script to generate JSON
node ../modulesJson/generate.mjs


cd ..

# Copy JSON
cp build/modules.json out/modules.json
cp -r build/clone/modules out/modules

# Copy _headers file
cp _headers out/_headers