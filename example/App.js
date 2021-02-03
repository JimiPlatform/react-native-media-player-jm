import React, { Component } from 'react';
import { Platform, StyleSheet, Image, Text, View, Dimensions, Button, TouchableOpacity, NativeModules, NativeEventEmitter } from 'react-native';
import { JMMeidaMonitor } from 'react-native-media-player-jm';
import RNFS from 'react-native-fs';
const { height, width } = Dimensions.get('window');
const {
    JMMediaPlayer
} = NativeModules;

export default class App extends Component<Props> {
    state = {
        managerListener: new NativeEventEmitter(JMMediaPlayer),
        playStatusSubscription: null,
        recordStatusSubscription: null,
        frameInfoSubscription: null,
        mute: false
    };

    componentWillMount() {
        playStatusSubscription = this.state.managerListener.addListener(JMMediaPlayer.kOnMediaPlayerPlayStatus, (reminder) => {
            console.log(reminder);
            if (reminder.status == JMMediaPlayer.playStatusPrepare) {
                console.log("Media is ready to play");
            } else if (reminder.status == JMMediaPlayer.playStatusStart) {
                console.log("Media has started playing");
            } else if (reminder.status == JMMediaPlayer.playStatusFailed) {
                console.log("Media has stopped playing");
            } else {
                console.log("Media play status code:" + reminder.status + ", Errcode: " + reminder.errCode + ", ErrMsg: " + reminder.errMsg);
            }
        });
        recordStatusSubscription = this.state.managerListener.addListener(JMMediaPlayer.kOnMediaPlayerRecordStatus, (reminder) => {
            console.log(reminder);
        });
        frameInfoSubscription = this.state.managerListener.addListener(JMMediaPlayer.kOnMediaPlayerReceiveFrameInfo, (reminder) => {
//            console.log(reminder);
        });
    }

    componentWillUnmount() {
        if (playStatusSubscription) playStatusSubscription.remove();
        if (recordStatusSubscription) recordStatusSubscription.remove();
        if (frameInfoSubscription) frameInfoSubscription.remove();
    }


    render() {
        return (
            <View style={{ flex: 1, backgroundColor: '#FFF' }}>
                <JMMeidaMonitor
                    style={{ width: width, height: 300}}            //Set display monitor frame
                    image={require('./res/image/screenShot.png')}   //Load default image
                >
                </JMMeidaMonitor>

                <View style={{ flexDirection: 'row', justifyContent: 'space-between', width: width, height: 40, marginTop: 10 }}>
                    <TouchableOpacity style={styles.btnStyle1} onPress={() => { this.clickedInitSDK() }}>
                        <Text style={styles.baseStyle}>SDK Init</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle1} onPress={() => { this.clickedReleaseSDK() }}>
                        <Text style={styles.baseStyle}>SDK Deinit</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle1} onPress={() => { this.clickedStartPlay() }}>
                        <Text style={styles.baseStyle}>StartPlay</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle1} onPress={() => { this.clickedStopPlay() }}>
                        <Text style={styles.baseStyle}>StopPlay</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle1} onPress={() => { this.clickedMute() }}>
                        <Text style={styles.baseStyle}>Mute</Text>
                    </TouchableOpacity>
                </View>

                <View style={{ flexDirection: 'row', justifyContent: 'space-between', width: width, height: 40, marginTop: 10 }}>
                    <TouchableOpacity style={styles.btnStyle2} onPress={() => { this.clickedStartRecording() }}>
                        <Text style={styles.baseStyle}>StartRecord</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle2} onPress={() => { this.clickedStopRecording() }}>
                        <Text style={styles.baseStyle}>StopRecord</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle2} onPress={() => { this.clickedGetDuration() }}>
                        <Text style={styles.baseStyle}>RecordDuration</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btnStyle2} onPress={() => { this.clickedSnapshot() }}>
                        <Text style={styles.baseStyle}>Snapshot</Text>
                    </TouchableOpacity>
                </View>
            </View>
        );
    }

    clickedInitSDK() {
        JMMediaPlayer.initialize()
    }

    clickedReleaseSDK() {
        JMMediaPlayer.deInitialize()
    }

    clickedStartPlay() {
        JMMediaPlayer.play("rtmp://58.200.131.2:1935/livetv/channelv").then(data => {
            console.log(data);
        }).catch(e => {
            console.log(e);
        });
    }

    clickedStopPlay() {
        JMMediaPlayer.stop()
    }

    clickedStartRecording() {
        const path = Platform.OS === 'android' ? (RNFS.ExternalStorageDirectoryPath + "/") : RNFS.TemporaryDirectoryPath;
        console.log(path);
        JMMediaPlayer.startRecord(path + "123.mp4").then(data => {
            console.log(data);
        }).catch(e => {
            console.log(e);
        });
        //Specific example path，such as:"/Users/lzj/Library/Developer/CoreSimulator/Devices/021EF370-EB9F-4D6D-808C-90D44B213009/data/Containers/Data/Application/307AB34A-652E-4F56-AE02-B7C82A75F3DB/tmp/123.mp4"
    }

    clickedStopRecording() {
        JMMediaPlayer.stopRecord();
    }

    clickedSnapshot() {
        const path = Platform.OS === 'android' ? (RNFS.ExternalStorageDirectoryPath + "/") : RNFS.TemporaryDirectoryPath;
        console.log(path);
        JMMediaPlayer.snapshot(path + "123.png").then(data => {
            console.log(data);
        }).catch(e => {
            console.log(e);
        });
        //Specific example path，such as: "/Users/lzj/Library/Developer/CoreSimulator/Devices/021EF370-EB9F-4D6D-808C-90D44B213009/data/Containers/Data/Application/307AB34A-652E-4F56-AE02-B7C82A75F3DB/tmp/123.png"
    }

    clickedMute() {
        this.setState({ mute: !this.state.mute }, () => {
            console.log("Media mute state: " + this.state.mute);
            JMMediaPlayer.setMute(this.state.mute);
        });
    }

    clickedGetDuration() {
        JMMediaPlayer.getRecordingDuration().then(data => {
            console.log(data);
        });
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },

    btnStyle1: {
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#AAFCFF',
        borderColor: '#ca6',
        borderWidth: 1,
        width: (width - 10) / 5
    },
    
    btnStyle2: {
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#AAFCFF',
        borderColor: '#ca6',
        borderWidth: 1,
        width: (width - 8) / 4
    }
});
