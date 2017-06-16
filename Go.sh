

#!/bin/sh

#git update
git checkout 分支名字

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
xcodebuild -target 工程名字 clean

xcodebuild archive -workspace 工程名字.xcworkspace -scheme 工程名字 -configuration Release -archivePath "$CONFIG_ROOT_PATH""/工程名字"

xcodebuild -exportArchive -archivePath "$CONFIG_ROOT_PATH""/工程名字.xcarchive"  -exportOptionsPlist "$CONFIG_ROOT_PATH""/工程名字/Info.plist" -exportPath "$CONFIG_ROOT_PATH"

#上 蒲公英
curl -F "file=@./工程名字.ipa" -F "uKey=蒲公英上userKey" -F "_api_key=蒲公英上apiKey" https://www.pgyer.com/apiv1/app/upload

