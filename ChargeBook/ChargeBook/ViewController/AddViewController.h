//
//  AddViewController.h
//  记账本
//
//  Created by William on 2018/2/13.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillList,AddViewController;
@protocol AddViewControllerDelegate <NSObject>
-(void)addViewController: (AddViewController *)addViewController sendBillList :(BillList *)billList;


@end

@interface AddViewController : UIViewController

@property (nonatomic,strong)id<AddViewControllerDelegate> delegate;

@property(nonatomic,assign)BOOL isEditStatement;

//时间的字符串
@property(nonatomic,copy)NSString *dateStr;

+(AddViewController *)editViewWithDate :(NSString *)date billListRemark :(BillListRemarks)remark productArray :(NSMutableArray *)array;

@end
