//
//  NSDictionary+NSDictionaryCategory.m
//  ChargeBook
//
//  Created by William on 2018/2/24.
//  Copyright © 2018年 William. All rights reserved.
//

#import "NSDictionary+NSDictionaryCategory.h"

@implementation NSDictionary (NSDictionaryCategory)

-(instancetype)billListDictionaryIncludeDateAndArray{
    NSString *date;
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:date,@"date", array, @"billArray",nil];
    return dict;
}

@end
