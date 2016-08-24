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
  git clone https://github.com/ETENG-WIKI/static-html-builder $buildDir
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
