#!/bin/sh

# Clean up and make build + out dir
# rm -rf build
# mkdir build

rm -rf out
mkdir out

# mkdir out/untethered
mkdir out/injectVersion

# NPM install for Node script
# cd modulesJson
# npm install


# cd ../build

# Clone repo
# git clone https://github.com/GooseMod/Modules clone

# Use Node script to generate JSON and copy over minified JS files
# node ../modulesJson/generate.mjs

# Copy _headers
# cd ..

cp CNAME out/CNAME

# Copy latest inject.js to out (for untethered)
wget --no-cache https://raw.githubusercontent.com/GooseMod/GooseMod/dist-prod/index.js -O out/inject.js

cat out/inject.js | grep "this.versionHash=\".*?\"" -P -o | cut -d "\"" -f 2 > out/injectVersion/hash.txt
cat out/inject.js | grep "this.version=\".*?\"" -P -o | cut -d "\"" -f 2 > out/injectVersion/version.txt

echo "{\"version\": \"$(cat out/injectVersion/version.txt)\", \"hash\": \"$(cat out/injectVersion/hash.txt)\"}" > out/injectVersion.json

# Copy PGP library
wget "https://unpkg.com/openpgp@5.0.0-5/dist/openpgp.min.js" -O out/pgp.js

# Copy latest changelog release into out generated via Node script
# cd changelog
# wget --no-cache https://raw.githubusercontent.com/GooseMod/GooseMod/master/CHANGELOG.md -O changelog.md
# node generate.mjs

# cd ..

# Copy latest untethered JS stuff to out (for untethered)
# wget --no-cache https://raw.githubusercontent.com/GooseMod/Untethered/master/src/untetheredInject.js -O out/untethered/untetheredInject.js
# wget https://raw.githubusercontent.com/GooseMod/Untethered/master/src/base.js -O out/untethered/base.js
