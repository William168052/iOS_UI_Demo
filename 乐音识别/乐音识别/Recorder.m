//
//  Recorder.m
//  乐音识别
//
//  Created by William on 2018/1/28.
//  Copyright © 2018年 William. All rights reserved.
//

#import "Recorder.h"
@interface Recorder()
{
    
    /*
     1.AudioQueueBuffer : 音频队列缓冲区
       1.1 AudioQueueBufferRef为指向AudioQueueBuffer的指针
       1.2 每一个AudioQueue都有使队列连接起来的缓冲区，使用AudioQueueAllocateBuffer函数来创建一个缓冲区，使用AudioQueueFreeBuffer来释放一个缓冲区。
     2.typedef struct OpaqueAudioQueue *AudioQueueRef;
     AudioQueueRef是一个不透明的数据类型
     */
    //定义buffer数组
    AudioQueueBufferRef _audioBuffers[kNumberAudioQueueBuffers];
    AudioQueueRef _audioQueue;
    AudioStreamBasicDescription _recordFormat;
}

@end

@implementation Recorder

-(void)startRecording{
    
    //1.初始化录音的参数
    [self setupAudioFormat:kAudioFormatLinearPCM SampleRate:kDefaultSampleRate];
    
    NSError *error = nil;
    //设置audio session的category
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
    
    _recordFormat.mSampleRate = kDefaultSampleRate;//设置采样率，8000hz
    
    //初始化音频输入队列
    AudioQueueNewInput(&_recordFormat, inputBufferHandler, (__bridge void *)(self), NULL, NULL, 0, &_audioQueue);//inputBufferHandler这个是回调函数名
    
    
    //计算估算的缓存区大小
    int frames = (int)ceil(kDefaultBufferDurationSeconds * _recordFormat.mSampleRate);//返回大于或者等于指定表达式的最小整数
    int bufferByteSize = frames * _recordFormat.mBytesPerFrame;//缓冲区大小在这里设置，这个很重要，在这里设置的缓冲区有多大，那么在回调函数的时候得到的inbuffer的大小就是多大。
    NSLog(@"缓冲区大小:%d",bufferByteSize);
    
    //创建缓冲器
    for (int i = 0; i < kNumberAudioQueueBuffers; i++){
        AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
        AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);//将 _audioBuffers[i]添加到队列中
    }
    
    // 开始录音
    AudioQueueStart(_audioQueue, NULL);
    
    self.isRecording = YES;
}

-(void)stopRecording{
    NSLog(@"stop recording out\n");//为什么没有显示
    if (self.isRecording)
    {
        self.isRecording = NO;
        
        //停止录音队列和移除缓冲区,以及关闭session，这里无需考虑成功与否
        AudioQueueStop(_audioQueue, true);
        AudioQueueDispose(_audioQueue, true);//移除缓冲区,true代表立即结束录制，false代表将缓冲区处理完再结束
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        
    }
}

#pragma marking RecordingMethods
// 设置录音格式
- (void)setupAudioFormat:(UInt32) inFormatID SampleRate:(int)sampeleRate
{
    //重置下
    memset(&_recordFormat, 0, sizeof(_recordFormat));
    
    //设置采样率，这里先获取系统默认的测试下 //TODO:
    //采样率的意思是每秒需要采集的帧数
    _recordFormat.mSampleRate = sampeleRate;//[[AVAudioSession sharedInstance] sampleRate];
    
    //设置通道数,这里先使用系统的测试下 //TODO:
    _recordFormat.mChannelsPerFrame = 1;//(UInt32)[[AVAudioSession sharedInstance] inputNumberOfChannels];
    
    //    NSLog(@"sampleRate:%f,通道数:%d",_recordFormat.mSampleRate,_recordFormat.mChannelsPerFrame);
    
    //设置format，怎么称呼不知道。
    _recordFormat.mFormatID = inFormatID;
    
    if (inFormatID == kAudioFormatLinearPCM){
        //这个属性不知道干啥的要看看是不是这里属性设置问题
        _recordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        //每个通道里，一帧采集的bit数目
        _recordFormat.mBitsPerChannel = 16;
        //结果分析: 8bit为1byte，即为1个通道里1帧需要采集2byte数据，再*通道数，即为所有通道采集的byte数目。
        //所以这里结果赋值给每帧需要采集的byte数目，然后这里的packet也等于一帧的数据。
        //至于为什么要这样不知道
        _recordFormat.mBytesPerPacket = _recordFormat.mBytesPerFrame = (_recordFormat.mBitsPerChannel / 8) * _recordFormat.mChannelsPerFrame;
        _recordFormat.mFramesPerPacket = 1;
    }
}

void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc)
{
    NSLog(@"we are in the 回调函数\n");
    Recorder *recorder = (__bridge Recorder *)inUserData;
    
    if (inNumPackets > 0 && recorder.isRecording) {
        NSLog(@"in the callback the current thread is %@\n",[NSThread currentThread]);

        int pcmSize = inBuffer->mAudioDataByteSize;
        char *pcmData = (char *)inBuffer->mAudioData;
        NSData *data = [[NSData alloc] initWithBytes:pcmData length:pcmSize];
        
        if (recorder.recordQueue) {
            [recorder.recordQueue appendData:data];
        }
        
    }
    
    AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);

}


void DeriveBufferSize(AudioQueueRef audioQueue,AudioStreamBasicDescription ASBDescription,Float64 seconds,UInt32 *outBufferSize){
    static const int maxBufferSize = 0x50000;
    int maxPacketSize = ASBDescription.mBytesPerPacket;
    if(maxPacketSize == 0){
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
    AudioQueueGetProperty(audioQueue,kAudioQueueProperty_MaximumOutputPacketSize,&maxPacketSize,&maxVBRPacketSize);
    }
    
    Float64 numBytesForTime = ASBDescription.mSampleRate * maxPacketSize * seconds; // 8
    *outBufferSize = (UInt32)(numBytesForTime < maxBufferSize ? numBytesForTime : maxBufferSize);                     // 9
}

@end
