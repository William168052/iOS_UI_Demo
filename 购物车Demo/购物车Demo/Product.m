//
//  Product.m
//  购物车Demo
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithDictionary :(NSDictionary *)dict{
    if(self = [super init]){
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
    }
    return self;
}

//字典转模型
+(NSArray *)productsWithDictionaryArray :(NSArray *)dictArray{
    //创建数组
    NSMutableArray *arr = [NSMutableArray array];
    
    //遍历字典数组
    [dictArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        Product *p = [[Product alloc] initWithDictionary:dict];
        [arr addObject:p];
    }];
    
    //返回数组
    return [NSArray arrayWithArray:arr];
    
}


@end
