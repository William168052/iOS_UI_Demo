//
//  UsersViewController.h
//  通讯录
//
//  Created by William on 2018/1/2.
//  Copyright © 2018年 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactPerson;
@interface UsersViewController : UITableViewController

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) ContactPerson *contactPerson;

@end
