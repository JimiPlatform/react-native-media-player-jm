//
//  RNJMMediaConstant.h
//  RNJMMediaPlayer
//
//  Created by lzj on 2021/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kOnMediaPlayerPlayStatus;
extern NSString *const kOnMediaPlayerTalkStatus;
extern NSString *const kOnMediaPlayerRecordStatus;
extern NSString *const kOnMediaPlayerReceiveFrameInfo;

@interface RNJMMediaConstant : NSObject

+ (NSDictionary *)constantsToExport;

@end

NS_ASSUME_NONNULL_END
