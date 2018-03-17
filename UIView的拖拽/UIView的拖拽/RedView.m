//
//  RedView.m
//  UIView的拖拽
//
//  Created by William on 2018/3/12.
//  Copyright © 2018年 William. All rights reserved.
//

#import "RedView.h"

@implementation RedView 

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    UITouch *touch = [touches anyObject];
    //求偏移量（手指当前点减去手指上一个点）
    CGPoint curP = [touch locationInView:self];
    CGPoint preP = [touch previousLocationInView:self];
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    //平移
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

@end
