//
//  Recorder.h
//  乐音识别
//
//  Created by William on 2018/1/28.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVFoundation.h>
//#import <AudioToolbox/AudioToolbox.h>
#define kNumberAudioQueueBuffers 3  //定义音频队列缓冲区的数量
typedef struct AQRecorderState{
    //音频流数据格式（AudioStreamBasicDescription结构体）
    AudioStreamBasicDescription  mDataFormat;
    //音频队列
    AudioQueueRef                mQueue;
    //音频队列缓冲区的指针数组
    AudioQueueBufferRef          mBuffers[kNumberAudioQueueBuffers];
    //音频文件对象（程序将音频数据记录到此文件）
    AudioFileID                  mAudioFile;
    //每个音频队列缓冲区的大小（以字节为单位）这个值是在音频队列被创建之后，在它被启动之前通过DeriveBufferSize函数计算出来的
    UInt32                       bufferByteSize;
    //要从当前音频队列缓冲区写入的第一个数据包的数据包索引
    SInt64                       mCurrentPacket;
    //指示音频队列是否正在运行的布尔值
    bool                         mIsRunning;
}RecorderState;
//调整这个值使得录音的缓冲区大小为2048bytes
#define kDefaultBufferDurationSeconds 0.1279
//定义采样率为8000
#define kDefaultSampleRate 8000

@interface Recorder : NSObject

@property (nonatomic, assign) BOOL isRecording;
@property (nonatomic, assign) NSMutableData *recordQueue;


-(void)startRecording;

-(void)stopRecording;

@end
