install:
	xcodebuild clean build -scheme QuickCode -derivedDataPath ./build -configuration Release
	cp -R ./build/Build/Products/Release/QuickCode.app /Applications/QuickCode.app
	rm -rf ./build