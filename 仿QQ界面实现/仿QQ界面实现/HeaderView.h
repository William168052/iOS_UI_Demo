//
//  HeaderView.h
//  仿QQ界面实现
//
//  Created by William on 06/01/2018.
//  Copyright © 2018 William. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewController;
@interface HeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,strong) UIViewController *targetVC;
+(instancetype)headerViewWithFrame :(CGRect)frame;



@end

