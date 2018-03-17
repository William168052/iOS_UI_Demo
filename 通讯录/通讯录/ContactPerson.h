//
//  ContactPerson.h
//  通讯录
//
//  Created by William on 2018/1/3.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactPerson : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phoneNum;

+ (instancetype)personWithName :(NSString *)name andPhoneNumber :(NSString *)number;

@end
