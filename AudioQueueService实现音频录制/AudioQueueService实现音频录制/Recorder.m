//
//  Recorder.m
//  AudioQueueService实现音频录制
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import "Recorder.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#define kNumberAudioQueueBuffers 3    //定义音频队列缓冲区的数量
#define kSampleRate 44100.0

typedef struct AQRecorderState{
    //音频流数据格式（AudioStreamBasicDescription结构体）
    AudioStreamBasicDescription mDataFormat;
    //音频队列
    AudioQueueRef mQueue;
    //音频队列缓冲区的指针数组
    AudioQueueBufferRef mBuffers[kNumberAudioQueueBuffers];
    //音频文件对象（程序将音频数据记录到此文件）
    AudioFileID mAudioFile;
    //每个音频队列缓冲区的大小（以字节为单位）这个值是在音频队列被创建之后，在它被启动之前通过DeriveBufferSize函数计算出来的
    UInt32 bufferByteSize;
    //要从当前音频队列缓冲区写入的第一个数据包的数据包索引
    SInt64 mCurrentPacket;
    //指示音频队列是否正在运行的布尔值
    bool mIsRunning;
}RecorderState;

@interface Recorder()
{
    RecorderState _aqData;
}

//@property (nonatomic,assign)

@end

@implementation Recorder

-(void)startRecording:(NSURL *)url{
    //录制音频
    _aqData.mCurrentPacket = 0;
    _aqData.mIsRunning = true;
    //设置audio session的category
    NSError *error = nil;
    BOOL ret = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:&error];//注意，这里选的是AVAudioSessionCategoryPlayAndRecord参数，如果只需要录音，就选择Record就可以了，如果需要录音和播放，则选择PlayAndRecord，这个很重要
    if (!ret) {
        NSLog(@"设置声音环境失败");
        return;
    }
    //启用audio session
    ret = [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (!ret)
    {
        NSLog(@"启动失败");
        return;
    }
    
    //设置录制的音频格式
    [self setupAudioFormat:kAudioFormatLinearPCM SampleRate:kSampleRate];
    
    AudioFileTypeID fileType = kAudioFileAIFFType;
    
    //创建一个录音音频队列
    AudioQueueNewInput (&_aqData.mDataFormat,HandleInputBuffer,&_aqData,NULL,kCFRunLoopCommonModes,0,&_aqData.mQueue);
    //从音频队列中获取完整的音频格式
    UInt32 dataFormatSize = sizeof (_aqData.mDataFormat);
    
    AudioQueueGetProperty (_aqData.mQueue,kAudioQueueProperty_StreamDescription,&_aqData.mDataFormat,&dataFormatSize);
    
    //创建一个音频文件
    NSString *urlStr = [url absoluteString];
    const char *filePath = [urlStr cStringUsingEncoding:NSASCIIStringEncoding];
    CFURLRef audioFileURL =
    CFURLCreateFromFileSystemRepresentation (NULL,(const UInt8 *) filePath,strlen (filePath),false);
    
    AudioFileCreateWithURL (audioFileURL,fileType,&_aqData.mDataFormat,kAudioFileFlags_EraseFile,&_aqData.mAudioFile);
    
    //设置音频队列缓冲区大小
    DeriveBufferSize (_aqData.mQueue,_aqData.mDataFormat,0.5,&_aqData.bufferByteSize);
    
    //准备一组音频队列缓冲区
    for (int i = 0; i < kNumberAudioQueueBuffers; ++i) {
        AudioQueueAllocateBuffer (_aqData.mQueue,_aqData.bufferByteSize,&_aqData.mBuffers[i]);
        
        AudioQueueEnqueueBuffer (_aqData.mQueue,_aqData.mBuffers[i],0,NULL);
    }
    AudioQueueStart (_aqData.mQueue,NULL);
     
    
}
-(void)stopRecording{
    //在用户界面线程上等待，直到用户停止录制
    AudioQueueStop (_aqData.mQueue,true);
    _aqData.mIsRunning = false;
    
    AudioQueueDispose (_aqData.mQueue,true);
    
    AudioFileClose (_aqData.mAudioFile);
}

//初始化录音参数
- (void)setupAudioFormat:(UInt32) inFormatID SampleRate:(int)sampeleRate{
    _aqData.mDataFormat.mFormatID = inFormatID;
    _aqData.mDataFormat.mSampleRate = sampeleRate;
    _aqData.mDataFormat.mChannelsPerFrame = 2;
    _aqData.mDataFormat.mBitsPerChannel = 16;
    _aqData.mDataFormat.mBytesPerPacket = _aqData.mDataFormat.mBytesPerFrame = _aqData.mDataFormat.mChannelsPerFrame * sizeof (SInt16);
    _aqData.mDataFormat.mFramesPerPacket = 1;
    _aqData.mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger |kLinearPCMFormatFlagIsPacked;
}

//录音音频队列回调函数
static void HandleInputBuffer(void *aqData,AudioQueueRef inAQ,AudioQueueBufferRef inBuffer,const AudioTimeStamp                 *inStartTime,UInt32 inNumPackets,const AudioStreamPacketDescription *inPacketDesc){
    RecorderState *pAqData = (RecorderState *)aqData;
    
    if (inNumPackets == 0 &&pAqData->mDataFormat.mBytesPerPacket != 0)
        inNumPackets = inBuffer->mAudioDataByteSize / pAqData->mDataFormat.mBytesPerPacket;
    if (AudioFileWritePackets (pAqData->mAudioFile,false,inBuffer->mAudioDataByteSize,inPacketDesc,pAqData->mCurrentPacket,&inNumPackets,inBuffer->mAudioData) == noErr){
        pAqData->mCurrentPacket += inNumPackets;
    }
    if (pAqData->mIsRunning == 0)
        return;
    AudioQueueEnqueueBuffer (pAqData->mQueue,inBuffer,0,NULL);
}

//记录音频队列缓冲区大小导出函数
void DeriveBufferSize(AudioQueueRef audioQueue,AudioStreamBasicDescription  ASBDescription,Float64 seconds,UInt32 *outBufferSize){
    static const int maxBufferSize = 0x50000;
    int maxPacketSize = ASBDescription.mBytesPerPacket;
    if (maxPacketSize == 0){
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
        AudioQueueGetProperty(audioQueue, kAudioQueueProperty_MaximumOutputPacketSize, &maxPacketSize, &maxVBRPacketSize);
    }
    
    Float64 numBytesForTime = ASBDescription.mSampleRate * maxPacketSize * seconds;
    *outBufferSize = (UInt32)(numBytesForTime < maxBufferSize ?
            numBytesForTime : maxBufferSize);
}

//为音频文件设置一个 Magic Cookie
OSStatus SetMagicCookieForFile(AudioQueueRef inQueue,AudioFileID inFile){
    OSStatus result = noErr;
    UInt32 cookieSize;
    if(AudioQueueGetPropertySize(inQueue,kAudioQueueProperty_MagicCookie,&cookieSize) == noErr){
        char* magicCookie = (char *)malloc(cookieSize);
        if(AudioQueueGetProperty(inQueue,kAudioQueueProperty_MagicCookie,magicCookie,&cookieSize) == noErr)
            result = AudioFileSetProperty(inFile,kAudioFilePropertyMagicCookieData,cookieSize,magicCookie);
        free (magicCookie);
    }
    return result;                                      
}

@end
