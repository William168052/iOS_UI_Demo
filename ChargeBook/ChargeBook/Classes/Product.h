//
//  Product.h
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject<NSCoding>
//商品名称
@property(nonatomic,copy)NSString *name;
//计数单位
@property(nonatomic,strong)NSString *unit;
//数量
@property(nonatomic,assign)NSInteger number;
//总价
@property(nonatomic,assign)double price;
//product所对应cell的index



+(instancetype)productWithName :(NSString *)name unit :(NSString *)unit number :(NSInteger)number andPrice :(double)price;
@end
