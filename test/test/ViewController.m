//
//  ViewController.m
//  test
//
//  Created by William on 2018/2/14.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "FloatList.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FloatList *list = [[FloatList alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    list.backgroundColor = [UIColor redColor];
    [self.view addSubview:list];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
