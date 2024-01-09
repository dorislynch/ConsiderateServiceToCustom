
# react-native-considerate-service-to-custom

## Getting started

`$ npm install react-native-considerate-service-to-custom --save`

### Mostly automatic installation

`$ react-native link react-native-considerate-service-to-custom`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-considerate-service-to-custom` and add `RNConsiderateServiceToCustom.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNConsiderateServiceToCustom.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNConsiderateServiceToCustomPackage;` to the imports at the top of the file
  - Add `new RNConsiderateServiceToCustomPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-considerate-service-to-custom'
  	project(':react-native-considerate-service-to-custom').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-considerate-service-to-custom/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-considerate-service-to-custom')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNConsiderateServiceToCustom.sln` in `node_modules/react-native-considerate-service-to-custom/windows/RNConsiderateServiceToCustom.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Considerate.Service.To.Custom.RNConsiderateServiceToCustom;` to the usings at the top of the file
  - Add `new RNConsiderateServiceToCustomPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNConsiderateServiceToCustom from 'react-native-considerate-service-to-custom';

// TODO: What to do with the module?
RNConsiderateServiceToCustom;
```
  