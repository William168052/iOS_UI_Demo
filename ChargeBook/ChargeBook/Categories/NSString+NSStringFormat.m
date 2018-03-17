//
//  NSString+NSStringFormat.m
//  记账本
//
//  Created by William on 2018/2/15.
//  Copyright © 2018年 William. All rights reserved.
//

#import "NSString+NSStringFormat.h"

@implementation NSString (NSStringFormat)

+(NSNumber *)formatStringToNSNumberObject :(NSString *)string{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [numberFormatter numberFromString:string];
    return number;
}



@end
