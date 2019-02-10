# react-native-audio-decoder

## Getting started

`$ npm install react-native-audio-decoder --save`

### Mostly automatic installation

`$ react-native link react-native-audio-decoder`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-audio-decoder` and add `RNAudioDecoder.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNAudioDecoder.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.RNAudioDecoderPackage;` to the imports at the top of the file
  - Add `new RNAudioDecoderPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-audio-decoder'
  	project(':react-native-audio-decoder').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-audio-decoder/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-audio-decoder')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNAudioDecoder.sln` in `node_modules/react-native-audio-decoder/windows/RNAudioDecoder.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Audio.Decoder.RNAudioDecoder;` to the usings at the top of the file
  - Add `new RNAudioDecoderPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNAudioDecoder from 'react-native-audio-decoder';

// TODO: What to do with the module?
RNAudioDecoder;
```
  