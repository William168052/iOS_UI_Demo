//
//  Recorder.h
//  AudioQueueService实现音频录制
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recorder : NSObject

-(void)startRecording :(NSURL *)url;

-(void)stopRecording;

@end
