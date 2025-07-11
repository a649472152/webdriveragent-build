#!/bin/bash
p=$(pwd)
build_test() {
  rm -rf /tmp/derivedDataPath/*
  #xcodebuild build-for-testing -project easyclick.xcodeproj CODE_SIGN_IDENTITY="8EEC448E51DBE8ADC37BA8A8135253F3BEB0EA70" -scheme WebDriverAgentRunner -sdk iphoneos -configuration Release -derivedDataPath /tmp/derivedDataPath -allowProvisioningUpdates
  xcodebuild build-for-testing -project tj-easyclick-agent.xcodeproj -scheme WebDriverAgentRunner -sdk iphoneos -configuration Release -derivedDataPath /tmp/derivedDataPath -allowProvisioningUpdates
  cd /tmp/derivedDataPath
  cd Build/Products/Release-iphoneos
  rm -r IntegrationApp.app
  mkdir Payload && mv *.app Payload
  zip -r tj-easyclick-agent.ipa Payload
  tidevice parse tj-easyclick-agent.ipa
  tidevice install tj-easyclick-agent.ipa
 cp tj-easyclick-agent.ipa $p

}

#sed -i -e 's/DEVELOPMENT_TEAM\ =\ .*/DEVELOPMENT_TEAM\ =\ ''"'7RCVR6G7VX'"''\;/' easyclick.xcodeproj/project.pbxproj


# 直接运行test
#xcodebuild -project easyclick.xcodeproj -DDEVELOPMENT_TEAM '7RCVR6G7VX' -scheme WebDriverAgentRunner -destination "id=`idevice_id -l | head -n1`" test

#xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner -destination id='your-udid' test -allowProvisioningUpdates
# 查看本机签名
# security find-identity -v -p codesigning

build_test
#build_app
