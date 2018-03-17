//
//  PlistManager.m
//  ChargeBook
//
//  Created by William on 2018/2/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager

+(BOOL)writePlistFileWithData :(NSArray *)data andFileName :(NSString *)name{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //获取完整路径
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];//这里就是你将要存储的沙盒路径（.plist文件，名字自定义）
    
    return [data writeToFile:plistPath atomically:YES];
}

+(NSArray *)readPlistFileWithName:(NSString *)name{
    //获取路径
    NSArray *sandboxpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[sandboxpath objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
    //获取数据
    NSArray *arrMain = [NSArray arrayWithContentsOfFile:filePath];
    return arrMain;
    
}


+(BOOL)deletePlistFileWithName:(NSString *)name{
    NSFileManager *manager=[NSFileManager defaultManager];
    //文件路径
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:name];//这里就是你将要删除的沙盒路径（.plist文件，名字自定义）
    
    return [manager removeItemAtPath:filepath error:nil];
    
}

@end
