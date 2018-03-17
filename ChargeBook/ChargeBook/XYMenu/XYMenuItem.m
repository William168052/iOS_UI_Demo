//
//  XYMenuItem.m
//  XYMenu
//
//  Created by FireHsia on 2018/1/26.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "XYMenuItem.h"


@interface XYMenuItem ()

@property (nonatomic, strong) UILabel *titleLab; // title
@property (nonatomic, copy) NSString *title;

@end

@implementation XYMenuItem



- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _title = title;
    }
    return self;
}

- (void)setUpViewsWithRect:(CGRect)rect
{
    self.frame = rect;
    CGFloat kItemHeight = self.bounds.size.height;
    CGFloat labelHeight = kItemHeight / 3;
    self.titleLab.frame = CGRectMake(0, labelHeight, self.bounds.size.width, labelHeight);
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.titleLab];
    
    
    
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.text = _title;
        _titleLab.font = [UIFont systemFontOfSize:14.0];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}

@end
