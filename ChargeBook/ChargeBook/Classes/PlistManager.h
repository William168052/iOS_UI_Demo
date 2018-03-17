//
//  PlistManager.h
//  ChargeBook
//
//  Created by William on 2018/2/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistManager : NSObject

+(BOOL)writePlistFileWithData :(NSArray *)data andFileName :(NSString *)name;

+(NSArray *)readPlistFileWithName :(NSString *)name;

+(BOOL)deletePlistFileWithName :(NSString *)name;
@end
