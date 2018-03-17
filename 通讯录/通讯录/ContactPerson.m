//
//  ContactPerson.m
//  通讯录
//
//  Created by William on 2018/1/3.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ContactPerson.h"

@implementation ContactPerson

+ (instancetype)personWithName :(NSString *)name andPhoneNumber :(NSString *)number{
    ContactPerson *cp = [[ContactPerson alloc] init];
    cp.name = name;
    cp.phoneNum = number;
    return cp;
}

@end
