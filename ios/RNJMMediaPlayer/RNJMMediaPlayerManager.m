//
//  RNJMMediaPlayerManager.m
//  RNJMMediaPlayer
//
//  Created by lzj on 2021/2/2.
//

#import "RNJMMediaPlayerManager.h"
#import "RNJMMonitorManager.h"
#import "RNJMMediaConstant.h"
#import <JMSmartMediaPlayer/JMSmartMediaPlayer.h>

JMMediaNetworkPlayer *gJMMediaNetworkPlayer = nil;

@interface RNJMMediaPlayerManager () <JMMediaNetworkPlayerDelegate>

@property (nonatomic, assign) BOOL hasListeners;

@end

@implementation RNJMMediaPlayerManager
RCT_EXPORT_MODULE(JMMediaPlayer);

- (void)startObserving {
    self.hasListeners = YES;
}

- (void)stopObserving {
    self.hasListeners = NO;
}

- (NSArray<NSString *> *)supportedEvents
{
    return @[kOnMediaPlayerPlayStatus,
             kOnMediaPlayerTalkStatus,
             kOnMediaPlayerRecordStatus,
             kOnMediaPlayerReceiveFrameInfo
    ];
}

- (NSDictionary *)constantsToExport
{
    return [RNJMMediaConstant constantsToExport];
}

- (void)sendEventWithName:(NSString *)eventName body:(id)body
{
    if (self.hasListeners) {
        [super sendEventWithName:eventName body:body];
    }
}

- (BOOL)isNoInitReject:(RCTPromiseRejectBlock)reject {
    if (!gJMMediaNetworkPlayer) {
        reject(@"-10000", @"Component is not initialized, call initialize.", nil);
        return YES;
    }
    return NO;
}

#pragma mark -

RCT_EXPORT_METHOD(initialize) {
    if (gJMMediaNetworkPlayer) return;
    
    gJMMediaNetworkPlayer = [[JMMediaNetworkPlayer alloc] init];
    gJMMediaNetworkPlayer.delegate = self;
    gJMMediaNetworkPlayer.sniffStreamEnable = YES;
    if (gRNJMMonitor) {
        [gJMMediaNetworkPlayer attachMonitor:gRNJMMonitor];
    }
}

RCT_EXPORT_METHOD(deInitialize) {
    if (!gJMMediaNetworkPlayer) return;
    
    gJMMediaNetworkPlayer.delegate = nil;
    [gJMMediaNetworkPlayer stop];
    [gJMMediaNetworkPlayer deattachMonitor];
    gJMMediaNetworkPlayer = nil;
}

RCT_EXPORT_METHOD(play:(NSString *)url resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }

    [gJMMediaNetworkPlayer play:url];
    resolve(@"");
}

RCT_EXPORT_METHOD(stop:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }

    [gJMMediaNetworkPlayer stop];
    resolve(@"");
}

RCT_EXPORT_METHOD(isPlaying:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }

    BOOL ret = [gJMMediaNetworkPlayer isPlaying];
    resolve(@(ret));
}

#pragma mark -

RCT_EXPORT_METHOD(startRecord:(NSString *)filePath resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }
    
    if (!filePath) {
        filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tempRecording.mp4"];
    } else if ([filePath hasPrefix:@"./"]) {
        filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[filePath substringFromIndex:1]];
    }
    
    [gJMMediaNetworkPlayer startRecord:filePath];
    resolve(@"");
}

RCT_EXPORT_METHOD(stopRecord:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }
    
    [gJMMediaNetworkPlayer stopRecord];
    resolve(@"");
}

RCT_EXPORT_METHOD(isRecording:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }

    BOOL ret = [gJMMediaNetworkPlayer isRecording];
    resolve(@(ret));
}

RCT_EXPORT_METHOD(getRecordingDuration:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }

    long duration = [gJMMediaNetworkPlayer getRecordingDuration];
    resolve(@(duration));
}

RCT_EXPORT_METHOD(snapshot:(NSString *)filePath resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }
    if (!gRNJMMonitor) {
        reject(@"-10001", @"Component's Monitor is null.", nil);
        return;
    }
    
    __block NSString *filePathT = filePath;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *img = [gJMMediaNetworkPlayer snapshot];
        if (img) {
            if (!filePathT) {
                filePathT = NSTemporaryDirectory();
            } else if ([filePathT hasPrefix:@"./"]) {
                filePathT = [NSTemporaryDirectory() stringByAppendingPathComponent:[filePathT substringFromIndex:1]];
            }

            NSString *extensionName = filePathT.pathExtension;
            if (!extensionName || !extensionName.length) {
                if (![[NSFileManager defaultManager] fileExistsAtPath:filePathT]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:filePathT withIntermediateDirectories:YES attributes:nil error:nil];
                }
                filePathT = [filePathT stringByAppendingPathComponent:@"tempSnapshot.png"];
            } else {
                NSArray *arr = [filePathT pathComponents];
                NSString *fileName = [arr lastObject];
                NSString *path = [filePathT substringToIndex:filePathT.length - fileName.length];
                if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
                    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                }
            }

            if ([UIImagePNGRepresentation(img) writeToFile:filePathT atomically:YES]) {
                resolve(filePathT);
            } else {
                reject(@"-10002", @"Failed to save image", nil);
            }
        } else {
            reject(@"-10003", @"Failed to do snapshot", nil);
        }
    });
}

RCT_EXPORT_METHOD(setMute:(BOOL)mute resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }
    gJMMediaNetworkPlayer.mute = mute;
    resolve(@"");
}

RCT_EXPORT_METHOD(getMute:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    if ([self isNoInitReject:reject]) { return; }
    resolve(@(gJMMediaNetworkPlayer.mute));
}

#pragma mark - JMVideoStreamPlayerDelegate

- (NSMutableDictionary *)getEmptyBody {
    NSMutableDictionary *body = @{}.mutableCopy;
    return body;
}

- (void)didJMMediaNetworkPlayerPlay:(JMMediaNetworkPlayer *_Nonnull)player status:(enum JM_MEDIA_PLAY_STATUS)status error:(JMError *_Nullable)error {
    NSMutableDictionary *body = [self getEmptyBody];
    [body setValue:@(status) forKey:@"status"];
    if (error) {
        [body setValue:@(error.errCode) forKey:@"errCode"];
        [body setValue:error.errMsg forKey:@"errMsg"];
    }
    
    [self sendEventWithName:kOnMediaPlayerPlayStatus body:body];
}

- (void)didJMMediaNetworkPlayerRecord:(JMMediaNetworkPlayer *_Nonnull)player status:(enum JM_MEDIA_RECORD_STATUS)status path:(NSString *_Nullable)filePath error:(JMError *_Nullable)error {
    NSMutableDictionary *body = [self getEmptyBody];
    [body setValue:@(status) forKey:@"status"];
    [body setValue:filePath forKey:@"filePath"];
    if (error) {
        [body setValue:@(error.errCode) forKey:@"errCode"];
        [body setValue:error.errMsg forKey:@"errMsg"];
    }
    
    [self sendEventWithName:kOnMediaPlayerRecordStatus body:body];
}

- (void)didJMMediaNetworkPlayerPlayInfo:(JMMediaNetworkPlayer *_Nonnull)player playInfo:(JMMediaPlayInfo *)playInfo {
    NSMutableDictionary *body = [self getEmptyBody];
    if (playInfo) {
        [body setValue:@(playInfo.videoWidth) forKey:@"videoWidth"];
        [body setValue:@(playInfo.videoHeight) forKey:@"videoHeight"];
        [body setValue:@(playInfo.videoBps) forKey:@"videoBps"];
        [body setValue:@(playInfo.audioBps) forKey:@"audioBps"];
        [body setValue:@(playInfo.timestamp) forKey:@"timestamp"];
        
        [self sendEventWithName:kOnMediaPlayerReceiveFrameInfo body:body];
    }
}


@end
