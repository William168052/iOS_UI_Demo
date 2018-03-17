//
//  ViewController.m
//  iOS多线程-GCD
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
    [self asyncMain];
}

//异步函数+并发队列(会开启多条线程，队列中任务是并发执行的)
-(void)asyncConcurrent{
    //创建并发队列
    /*方法一：
     const char * _Nullable label : 标识符（区分队列）
     dispatch_queue_attr_t  _Nullable attr : 队列的类型（DISPATCH_QUEUE_CONCURRENT ：并发，DISPATCH_QUEUE_SERIAL ：串行）
     */
//    dispatch_queue_t queue = dispatch_queue_create("A", DISPATCH_QUEUE_CONCURRENT);
    /*方法二：获得全局队列(本身存在的)
     long identifier : 队列优先级（DISPATCH_QUEUE_PRIORITY_DEFAULT/HIGH/LOW/BACKGROUND）
     unsigned long flags : 总是填0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //封装任务并添加任务到队列
    /*
     dispatch_queue_t  _Nonnull queue : 队列
     ^(void)block : 要执行的任务
     */
    dispatch_async(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
    
}

//异步函数+串行队列(会开启一条线程，队列中任务是串行 执行的)
-(void)asyncSerial{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("A", DISPATCH_QUEUE_SERIAL);
    //封装任务并添加任务到队列
    dispatch_async(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
    
}

//同步函数+并发队列(不会开启线程，队列中任务是串行执行的)
-(void)syncConcurrent{
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("A", DISPATCH_QUEUE_CONCURRENT);
    //封装任务并添加任务到队列
    dispatch_sync(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
    
}

//同步函数+串行队列(不会开启线程，队列中任务是串行执行的)
-(void)syncSerial{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("A", DISPATCH_QUEUE_SERIAL);
    //封装任务并添加任务到队列
    dispatch_sync(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
    
}

//异步函数+主队列(凡是放在主队列中的任务都会放在主线程执行，所以不会开启线程)
-(void)asyncMain{
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //封装任务并添加任务到队列
    dispatch_async(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
}
 

//同步函数+主队列 ：产生死锁（如果在子线程调用此方法则不会发生死锁）
-(void)syncMain{
    //获得主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //封装任务并添加任务到队列
    dispatch_sync(queue, ^{
        NSLog(@"download1-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download2-----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"download3-----%@",[NSThread currentThread]);
    });
}



@end
