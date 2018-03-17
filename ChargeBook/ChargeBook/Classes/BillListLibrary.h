//
//  BillListLibrary.h
//  ChargeBook
//
//  Created by William on 2018/2/24.
//  Copyright © 2018年 William. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BillList;

@interface BillListLibrary : NSObject<NSCoding>

@property (nonatomic,copy)NSString *date;
@property (nonatomic,strong) NSMutableArray<BillList *> *billArray;

@end
