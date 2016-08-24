#!/bin/sh

# check out the project
echo "Please input the svn path of your Project!"
read path
echo $path
echo "Please input your Project Name!"
read proname
echo $proname
svn co $path /data/$proname

# static-html-builder init
buildDir="${proname}Builder"
if [ ! -d "$buildDir" ]; then
  git clone https://github.com/JrontEnd/static-html-builder $buildDir
fi
cd $buildDir
npm install
rm -rf app
ln -s /data/$proname app
grunt init
bower install
grunt build

# cordova init
cd ..
cordovaDir="${proname}Cordova"
if [ ! -d "$cordovaDir" ]; then
  cordova create $cordovaDir
  cd $cordovaDir
  cordova platform add android
else
  cd $cordovaDir
fi
rm -rf www
ln -s /data/$buildDir/dist www
cordova build

root@58be56bfad79:/data# cat build.sh
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
