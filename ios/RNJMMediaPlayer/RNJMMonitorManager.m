//
//  RNJMMonitorManager.m
//  RNJMMediaPlayer
//
//  Created by lzj on 2021/2/2.
//

#import "RNJMMonitorManager.h"
#import <React/RCTConvert.h>

JMMonitor *gRNJMMonitor = nil;

@implementation RNJMMonitorManager
RCT_EXPORT_MODULE(JMMonitor)

RCT_CUSTOM_VIEW_PROPERTY(image, NSDictionary, JMMonitor) {
    UIImage *img = [RCTConvert UIImage:json];
    if (img) {
        [view displayImage:img];
    }
}

- (UIImageView *)view
{
    if (!gRNJMMonitor) {
        gRNJMMonitor = [[JMMonitor alloc] init];
        gRNJMMonitor.contentMode = UIViewContentModeScaleAspectFit;
    }

    return gRNJMMonitor;
}

@end
