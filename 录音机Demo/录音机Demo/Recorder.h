//
//  Recorder.h
//  AudioQueueService实现音频录制
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recorder : NSObject

//开始录音
-(void)startRecording :(NSURL *)url;
//暂停
-(void)pauseRecording;
//继续
-(void)startRecordAfterPause;
//停止录音
-(void)stopRecording;


@end
