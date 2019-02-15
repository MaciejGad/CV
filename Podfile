source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!
use_frameworks!

platform :ios, '10.0'

def libs()
    pod 'InjectStory'
    pod 'NibBased'
    pod "PromiseKit", "~> 6.0"
    pod 'FontAwesome.swift'
end



target 'CV' do
    libs()
end

target 'CVTests' do
	libs()
	pod 'iOSSnapshotTestCase'
end