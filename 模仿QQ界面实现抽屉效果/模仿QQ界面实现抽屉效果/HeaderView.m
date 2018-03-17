//
//  HeaderView.m
//  模仿QQ界面实现抽屉效果
//
//  Created by William on 06/01/2018.
//  Copyright © 2018 William. All rights reserved.
//

#import "HeaderView.h"
#import "UsersViewController.h"
#import "MainViewController.h"
@implementation HeaderView

+(instancetype)headerViewWithFrame :(CGRect)frame{
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];
    headerView.frame = frame;
    return headerView;
}

//点击左侧按钮将MainV移动到右侧
- (IBAction)leftBtnClicked:(UIButton *)sender {
    CGRect frame = self.targetVC.view.frame;
    frame.origin.x = LeftViewW;
    [UIView animateWithDuration:0.5 animations:^{
        self.targetVC.view.frame = frame;
    }];
}


- (IBAction)rightBtnClicked:(UIButton *)sender {
}




@end
