//
//  BillListLibrary.m
//  ChargeBook
//
//  Created by William on 2018/2/24.
//  Copyright © 2018年 William. All rights reserved.
//

#import "BillListLibrary.h"

@implementation BillListLibrary

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.billArray forKey:@"billArray"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.billArray = [aDecoder decodeObjectForKey:@"billArray"];
    }
    return self;
}

@end
