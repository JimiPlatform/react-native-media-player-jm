# react-native-media-player-jm [![npm version](https://img.shields.io/npm/v/react-native-media-player-jm.svg?style=flat)](https://www.npmjs.com/package/react-native-media-player-jm)

Jimi Media Player SDK modules and view for React Native(iOS & Android(Not supported)), support react native 0.57+

![Sample](https://raw.githubusercontent.com/JimiPlatform/react-native-media-player-jm/master/images/screenShot.png)

## Environments
- JS
  - node: 8.0+

- Android（Not currently supported）

  - Android SDK: api 28+

  - gradle: 4.5

  - Android Studio: 3.1.3+

- iOS

  - XCode: 10.0+

  - iOS  SDK：9.0+

## Install Component

`npm install react-native-media-player-jm --save`

or

`yarn add react-native-media-player-jm`

## Link Component

### Android Studio

`react-native link react-native-media-player-jm`

### Xcode

- Way1
  
- `react-native link react-native-media-player-jm`
  
- Way2

  Add the following content to Podfile of Project: 

```objective-c
  pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'CxxBridge',
    'DevSupport', 
    'RCTText',
    'RCTNetwork',
    'RCTWebSocket', 
    'RCTAnimation'
  ]
  pod 'yoga', :path => '../node_modules/react-native/ReactCommon/yoga'
  pod 'DoubleConversion', :podspec => '../node_modules/react-native/third-party-podspecs/DoubleConversion.podspec'
  pod 'glog', :podspec => '../node_modules/react-native/third-party-podspecs/glog.podspec'
  pod 'Folly', :podspec => '../node_modules/react-native/third-party-podspecs/Folly.podspec'

  pod 'react-native-media-player-jm', :podspec => '../node_modules/react-native-media-player-jm/react-native-media-player-jm.podspec'
```

## API Description 

#### Impot component

```
import { Platform, NativeModules, NativeEventEmitter } from 'react-native';
import { JMMeidaMonitor } from 'react-native-media-player-jm';
const { height, width } = Dimensions.get('window');
const {
  JMMediaPlayer
} = NativeModules;
```

#### JMMeidaMonitor

> This is a video display view. 

| Prop  | Type  | Default | Description  |
| ----- | ----- | ------- | ------------ |
| image | image | null    | display view |

#### JMMediaPlayer API

> This is media player API manager. 

| Method                   | Result Type | Result Content                                        | Description                                              |
| ------------------------ | ----------- | ----------------------------------------------------- | -------------------------------------------------------- |
| initialize               | null        | null                                                  | SDK initialize                                           |
| deInitialize             | null        | null                                                  | SDK deinitialize                                         |
| play(String url)         | Promise     | Success：""，Fail：see ErrCode Table                  | Play RTSP or RTMP video stream                           |
| stop                     | Promise     | Success：""，Fail：see ErrCode Table                  | Stop video stream                                        |
| isPlaying                | Promise     | Success：true or false，Fail：see ErrCode Table       | Is the video playing？                                   |
| startRecord(String path) | Promise     | Success：""，Fail：see ErrCode Table                  | start record video stream，PS：Video needs to be playing |
| stopRecord               | Promise     | Success：""，Fail：see ErrCode Table                  | stop record video stream                                 |
| isRecording              | Promise     | Success：true or false，Fail：see ErrCode Table       | Is recording a video？                                   |
| getRecordingDuration     | Promise     | Success：Int，Fail：see ErrCode Table                 | recording duration                                       |
| snapshot(String path)    | Promise     | Success：local img file path，Fail：see ErrCode Table | video snapshot                                           |
| setMute                  | Promise     | Success：""，Fail：see ErrCode Table                  | set video mute                                           |
| getMute                  | Promise     | Success：true or false，Fail：see ErrCode Table       | get video mute status                                    |

### JMMediaPlayer Listener

> This is media player status callback for listener. 

#### Play Status

- name：kOnMediaPlayerPlayStatus

- Content:

  - status：Int，See table below
  - errCode：Int，See ErrCode table
  - errMsg：String，Error message 

- Usage：

  ```javascript
  NativeEventEmitter(JMMediaPlayer).addListener(JMMediaPlayer.kOnMediaPlayerPlayStatus, (reminder) => {
       console.log(reminder);
  });
  ```

| Name              | Value | Description                                             |
| ----------------- | ----- | ------------------------------------------------------- |
| playStatusNone    | 0     | Stateless, initial state.                               |
| playStatusPrepare | 1     | Ready to play the video.                                |
| playStatusStart   | 2     | Video has started, or has been display.                 |
| playStatusStop    | 3     | Video has stopped，active call stop Api will not reply. |
| playStatusFailed  | 4     | Video failed to start play.                             |

#### Record Status

- name：kOnMediaPlayerRecordStatus
- Content:
  - status：Int，See table below
  - filePath：String，Locally recorded video mp4 file. 
  - errCode：Int，See ErrCode table
  - errMsg：String，Error message 

| Name                     | Value | Description                                     |
| ------------------------ | ----- | ----------------------------------------------- |
| recordStatusNone         | 0     | Stateless, initial state.                       |
| recordStatusStart        | 1     | Video recording has started.                    |
| recordStatusComplete     | 2     | Video has been recorded.                        |
| recordStatusFailed       | 3     | Video has failed to record.                     |
| recordStatusErrRecording | 4     | Video is being recorded and cannot start again. |

#### Receive Frame Info

- name：kOnMediaPlayerReceiveFrameInfo
- Content:
  - videoWidth：Int
  - videoHeight：Int
  - videoBps：Int
  - audioBps：Int
  - timestamp：Int

### ErrCode 

| Value  | Description                                    |
| ------ | ---------------------------------------------- |
| 0      | No Error                                       |
| -1     | Video stream url is invalid                    |
| -2     | path is invalid                                |
| -3     | Failed to open the url                         |
| -4     | Video playback was abnormally interrupted.     |
| -300   | Did not start playing                          |
| -301   | Recording initialization failed                |
| -302   | Recording in progress                          |
| -10000 | Component is not initialized, call initialize. |
| -10001 | Component's Monitor view is null.              |
| -10002 | Failed to save image                           |
| -10003 | Failed to do snapshot                          |

## JS Example 

[https://github.com/JimiPlatform/react-native-media-player-jm/tree/master/example/App.js](example/App.js)

