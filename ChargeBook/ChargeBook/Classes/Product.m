//
//  Product.m
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.unit forKey:@"unit"];
    [aCoder encodeInteger:self.number forKey:@"number"];
    [aCoder encodeDouble:self.price forKey:@"price"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self == [super init]){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.unit = [aDecoder decodeObjectForKey:@"unit"];
        self.number = [aDecoder decodeIntegerForKey:@"number"];
        self.price = [aDecoder decodeDoubleForKey:@"price"];
    }
    return self;
}

+(instancetype)productWithName :(NSString *)name unit :(NSString *)unit number :(NSInteger)number andPrice :(double)price{
    Product *product = [[Product alloc] init];
    product.name = name;
    product.unit = unit;
    product.number = number;
    product.price = price;
    return product;
}

@end
