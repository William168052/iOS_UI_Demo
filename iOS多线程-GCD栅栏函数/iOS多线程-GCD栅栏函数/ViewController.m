//
//  ViewController.m
//  iOS多线程-GCD栅栏函数
//
//  Created by William on 2018/3/17.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //穿件全局并发队列
    dispatch_queue_t queue = dispatch_queue_create("A", DISPATCH_QUEUE_CONCURRENT);
    //异步函数
    dispatch_async(queue, ^{
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    
    
    
    //栅栏函数：控制GCD中并发队列任务的执行顺序(栅栏函数中传入的队列不能用全局队列)
    dispatch_barrier_sync(queue, ^{
        NSLog(@"++++++++++++++++++++");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"3----%@",[NSThread currentThread]);
    });
}


@end
