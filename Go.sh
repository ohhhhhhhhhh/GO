

#!/bin/sh

#git update
git checkout dev_1.0

if [ $? -ne 0 ]; then
    exit 1
fi

#git pull
git pull
pod update --verbose --no-repo-update
if [ $? -ne 0 ]; then
    exit 1
fi

#path
CONFIG_ROOT_PATH="$(pwd)"

#删除
rm -rf "$CONFIG_ROOT_PATH""/build/"
#清除
xcodebuild -target RWHMagic clean

xcodebuild archive -workspace RWHMagic.xcworkspace -scheme RWHMagic -configuration Release -archivePath "$CONFIG_ROOT_PATH""/RWHMagic"

xcodebuild -exportArchive -archivePath "$CONFIG_ROOT_PATH""/RWHMagic.xcarchive"  -exportOptionsPlist "$CONFIG_ROOT_PATH""/RWHMagic/Info.plist" -exportPath "$CONFIG_ROOT_PATH"

#cd RWHMagic.ipa
#上 蒲公英
curl -F "file=@./RWHMagic.ipa" -F "uKey=bf0184bf9a7b96c9509f5ff614428c53" -F "_api_key=f64387aaebb4b518392a2e1f8353fc5a" https://www.pgyer.com/apiv1/app/upload

