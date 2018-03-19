//
//  App.h
//  iOS多线程-多图下载Demo
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *download;

+(instancetype)appWithDictionary :(NSDictionary *)dict;
@end
