//
//  RecordFile.h
//  录音机Demo
//
//  Created by William on 2018/2/9.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordFile : NSObject
@property(nonatomic,copy)NSString *mainName;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *audioLength;
@property(nonatomic,copy)NSString *fileURL;

-(instancetype)initWithMainName :(NSString *)mainName andCreateTime :(NSString *)createTime andAudioLength :(NSString *)audioLength andFileURL :(NSString *)url;
@end
