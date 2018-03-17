//
//  BillList.h
//  记账本
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Product;

@interface BillList : NSObject<NSCoding>
//时间
@property (nonatomic,copy)NSString *date;
//备注（进货/售出）
@property (nonatomic,assign)BillListRemarks remark;
//商品
@property (nonatomic,strong)NSMutableArray<Product *> *products;
//总价
@property (nonatomic,assign)double totle;

+(instancetype)billListWithDate :(NSString *)date billListRemarks :(BillListRemarks)remark products :(NSArray *)products andTotlePrice :(double)totlePrice;

@end
