//
//  RecordFile.m
//  录音机Demo
//
//  Created by William on 2018/2/9.
//  Copyright © 2018年 William. All rights reserved.
//

#import "RecordFile.h"

@implementation RecordFile
-(instancetype)initWithMainName :(NSString *)mainName andCreateTime :(NSString *)createTime andAudioLength :(NSString *)audioLength andFileURL:(NSString *)url{
    RecordFile *file = [[RecordFile alloc] init];
    file.mainName = mainName;
    file.createTime = createTime;
    file.audioLength = audioLength;
    file.fileURL = url;
    return file;
}

@end
