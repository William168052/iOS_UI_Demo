//
//  ViewController.m
//  iOS多线程-GCD实现单例模式
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "HBUTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HBUTool *tool1 = [[HBUTool alloc] init];
    HBUTool *tool2 = [[HBUTool alloc] init];
    HBUTool *tool3 = [HBUTool shareTool];
    HBUTool *tool4 = [tool3 copy];
    HBUTool *tool5 = [tool3 mutableCopy];
    NSLog(@"tool1 ------ %p , tool2 ------ %p , tool3 ------ %p , tool4 ------ %p , tool5 ------ %p",tool1,tool2,tool3,tool4,tool5);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
