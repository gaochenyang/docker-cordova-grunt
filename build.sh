#!/bin/sh

# switch the project
cd $3
svn switch $1
cd ..

# build html
pkill java
cd "$3Builder"
grunt init
grunt $2

# build apk
cd ../$4
#  copy signer
cp /data/$3/$5 config.xml
sed -i -e "s/{version}/$6/g" config.xml
if [ ! -z "$7" ]; then
  cp /data/$3/$7 release.keystore
  cordova build --release
else
  cordova build
fi
if [ ! -z "$7" ] && [ ! -z "$8" ] && [ ! -z "$9" ] && [ ! -z "$10" ]; then
  cp platforms/android/build/outputs/apk/$8 release.apk
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore release.keystore -storepass $9 release.apk $10
fi
