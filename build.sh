#!/bin/sh

# update the project
svn update $1

# build html
pkill java
cd "$1Builder"
grunt build

# build apk
cd ../$2
#  copy signer
cp /data/$1/$3 config.xml
if [ ! -z "$4" ]; then
  cp /data/$1/$4 release.keystore
  cordova build --release
else
  cordova build
fi
if [ ! -z "$4" ] && [ ! -z "$5" ] && [ ! -z "$6" ] && [ ! -z "$7" ]; then
  cp platforms/android/build/outputs/apk/$5 release.apk
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore release.keystore -storepass $6 release.apk $7
fi
