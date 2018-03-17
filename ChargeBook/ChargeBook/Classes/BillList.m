//
//  BillList.m
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import "BillList.h"

@implementation BillList

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.products forKey:@"products"];
    [aCoder encodeDouble:self.totle forKey:@"totle"];
    [aCoder encodeInt:self.remark forKey:@"remark"];

}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.products = [aDecoder decodeObjectForKey:@"products"];
        self.totle = [aDecoder decodeDoubleForKey:@"totle"];
        self.remark = [aDecoder decodeIntForKey:@"remark"];
    }
    return self;
}

+(instancetype)billListWithDate:(NSString *)date billListRemarks:(BillListRemarks)remark products:(NSArray *)products andTotlePrice:(double)totlePrice{
    BillList *list = [[BillList alloc] init];
    list.date = date;
    list.remark = remark;
    list.products = [NSMutableArray arrayWithArray:products];
    list.totle = totlePrice;
    return list;
}

@end
