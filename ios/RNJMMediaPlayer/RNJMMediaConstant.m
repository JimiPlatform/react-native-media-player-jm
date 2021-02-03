//
//  RNJMMediaConstant.m
//  RNJMMediaPlayer
//
//  Created by lzj on 2021/2/2.
//

#import "RNJMMediaConstant.h"
#import <JMSmartMediaPlayer/JMSmartMediaPlayer.h>

NSString *const kOnMediaPlayerPlayStatus = @"kOnMediaPlayerPlayStatus";
NSString *const kOnMediaPlayerTalkStatus = @"kOnMediaPlayerTalkStatus";
NSString *const kOnMediaPlayerRecordStatus = @"kOnMediaPlayerRecordStatus";
NSString *const kOnMediaPlayerReceiveFrameInfo = @"kOnMediaPlayerReceiveFrameInfo";

@implementation RNJMMediaConstant

+ (NSDictionary *)constantsToExport
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic addEntriesFromDictionary:@{kOnMediaPlayerPlayStatus: kOnMediaPlayerPlayStatus,
                                    kOnMediaPlayerTalkStatus: kOnMediaPlayerTalkStatus,
                                    kOnMediaPlayerRecordStatus: kOnMediaPlayerRecordStatus,
                                    kOnMediaPlayerReceiveFrameInfo: kOnMediaPlayerReceiveFrameInfo
                                    }];

    [dic addEntriesFromDictionary:@{@"playStatusNone": @(JM_MEDIA_PLAY_STATUS_NONE),
                                    @"playStatusPrepare": @(JM_MEDIA_PLAY_STATUS_PREPARE),
                                    @"playStatusStart": @(JM_MEDIA_PLAY_STATUS_START),
                                    @"playStatusStop": @(JM_MEDIA_PLAY_STATUS_STOP),
                                    @"playStatusErrURLGet": @(JM_MEDIA_PLAY_STATUS_FAILED)
    }];
    
    [dic addEntriesFromDictionary:@{@"talkStatusNone": @(JM_MEDIA_TALK_STATUS_NONE),
                                    @"talkStatusPrepare": @(JM_MEDIA_TALK_STATUS_PREPARE),
                                    @"talkStatusStart": @(JM_MEDIA_TALK_STATUS_START),
                                    @"talkStatusStop": @(JM_MEDIA_TALK_STATUS_STOP),
                                    @"talkStatusFailed": @(JM_MEDIA_TALK_STATUS_FAILED)
    }];
    
    [dic addEntriesFromDictionary:@{@"recordStatusNone": @(JM_MEDIA_RECORD_STATUS_NONE),
                                    @"recordStatusStart": @(JM_MEDIA_RECORD_STATUS_START),
                                    @"recordStatusComplete": @(JM_MEDIA_RECORD_STATUS_COMPLETE),
                                    @"recordStatusErrRecording": @(JM_MEDIA_RECORD_STATUS_FAILED),
                                    @"recordStatusErrFail": @(JM_MEDIA_RECORD_STATUS_RECORDING)
    }];
    
    [dic addEntriesFromDictionary:@{@"errorCodeNoErr": @(JM_MEDIA_ERR_NO_ERR),
                                    @"errorCodeUrlInvalid": @(JM_MEDIA_ERR_URL_INVALID),
                                    @"errorCodePathInvalid": @(JM_MEDIA_ERR_PATH_INVALID),
                                    @"errorCodeOpenFailed": @(JM_MEDIA_ERR_OPEN_FAILED),
                                    @"errorCodePlayAbnormal": @(JM_MEDIA_ERR_PLAY_ABNORMAL),
                                    @"errorCodeVideoDecodeFailed": @(JM_MEDIA_ERR_VIDEO_DECODE_FAILED),
                                    @"errorCodeAudioDecodeFailed": @(JM_MEDIA_ERR_AUDIO_DECODE_FAILED),
                                    @"errorCodeMicrophoneAuthority": @(JM_MEDIA_ERR_MICROPHONE_AUTHORITY),
                                    @"errorCodeMicrophoneInit": @(JM_MEDIA_ERR_MICROPHONE_INIT),
                                    @"errorCodeRecordNoPlay": @(JM_MEDIA_ERR_RECORD_NO_PLAY),
                                    @"errorCodeRecordInit": @(JM_MEDIA_ERR_RECORD_INIT),
                                    @"errorCodeRecording": @(JM_MEDIA_ERR_RECORD_RECORDING)
    }];
    
    [dic addEntriesFromDictionary:@{@"errorCodeSDKNoInit": @(-10000),
                                    @"errorCodeMonitorNoInit": @(-10001),
                                    @"errorCodeSnapshotSaveFailed": @(-10002),
                                    @"errorCodeSnapshotFailed": @(-10003),

    }];
    
    return dic;
}

@end
