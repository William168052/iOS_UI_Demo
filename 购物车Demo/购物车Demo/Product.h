//
//  Product.h
//  购物车Demo
//
//  Created by William on 2018/1/31.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;

+(NSArray *)productsWithDictionaryArray :(NSArray *)dictArray;
@end
