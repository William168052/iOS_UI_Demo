//
//  HBUTool.m
//  iOS多线程-GCD实现单例模式
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "HBUTool.h"

@implementation HBUTool
//提供全局变量
static HBUTool *_instance;
//重写allocWithZone方法(alloc会自动调用allocWithZone)
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //为保证线程安全（外界可能在其他线程上创建对象会导致线程不安全）
    //方法一：加互斥锁
//    @synchronized(self){
    //        if(_instance == nil){
    //            _instance = [super allocWithZone:zone];
    //        }
//    }
//
    //方法二：使用GCD的一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

//提供类方法
//1、方便访问
//2、表明身份（单例）
//3、命名规范：share+类名、default+类名、share、default、类名

+(instancetype)shareTool{
    return [[self alloc] init];
}


//重写CopyWithZone和MutableCopyWithZone方法（事先遵循NSCoping、NSMutableCoping协议，重写完方法之后再删除协议）
-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}


@end
