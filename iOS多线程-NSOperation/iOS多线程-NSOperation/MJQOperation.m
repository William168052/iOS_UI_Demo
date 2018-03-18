//
//  MJQOperation.m
//  iOS多线程-NSOperation
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "MJQOperation.h"

@implementation MJQOperation

//重写main方法包装任务
-(void)main{
    NSLog(@"%s----%@",__func__,[NSThread currentThread]);
}

@end
