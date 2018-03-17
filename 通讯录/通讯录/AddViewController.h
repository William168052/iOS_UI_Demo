//
//  AddViewController.h
//  通讯录
//
//  Created by William on 2018/1/3.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddViewController,ContactPerson;
//传值代理
@protocol AddViewControllerDelegate <NSObject>

//代理方法
//- (void)addContactAndReceiveReturnValueWithController :(AddViewController *)addVC;
- (void)addViewController :(AddViewController *)addVC contactPerson :(ContactPerson *)contactPerson;

@end
@interface AddViewController : UIViewController

@property (nonatomic,weak) id<AddViewControllerDelegate> delegate;

@end
