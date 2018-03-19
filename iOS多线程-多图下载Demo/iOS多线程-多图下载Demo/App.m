//
//  App.m
//  iOS多线程-多图下载Demo
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "App.h"

@implementation App

+(instancetype)appWithDictionary :(NSDictionary *)dict{
    App *app = [[App alloc] init];
    //KVC赋值字典转模型
    [app setValuesForKeysWithDictionary:dict];
    return app;
}

@end
