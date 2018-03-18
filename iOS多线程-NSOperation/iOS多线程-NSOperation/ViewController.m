//
//  ViewController.m
//  iOS多线程-NSOperation
//
//  Created by William on 2018/3/18.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"
#import "MJQOperation.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
}

//NSInvocationOperation和NSOperationQueue实现多线程
-(void)invocationOperation{
    //封装操作
    NSInvocationOperation *opr1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operate1) object:nil];
    NSInvocationOperation *opr2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operate2) object:nil];
    NSInvocationOperation *opr3 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operate3) object:nil];
    NSInvocationOperation *opr4 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operate4) object:nil];
    
    
    //创建队列
    NSOperationQueue *oprQueue = [[NSOperationQueue alloc] init];
    
    //添加任务到队列中
//    [oprQueue addOperation:opr1];
//    [oprQueue addOperation:opr2];
//    [oprQueue addOperation:opr3];
//    [oprQueue addOperation:opr4];
    
    [oprQueue addOperations:@[opr1,opr2,opr3,opr4] waitUntilFinished:YES];
    
}
//NSBlockOperation和NSOperationQueue实现多线程
-(void)blockOperation{
    //封装任务
    NSBlockOperation *opr1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
    }];
    
    [opr4 addExecutionBlock:^{
        NSLog(@"ex1----%@",[NSThread currentThread]);
        NSLog(@"ex2----%@",[NSThread currentThread]);
        NSLog(@"ex3----%@",[NSThread currentThread]);
        NSLog(@"ex4----%@",[NSThread currentThread]);
        NSLog(@"ex5----%@",[NSThread currentThread]);
        
    }];
    
    [opr4 addExecutionBlock:^{
        
        NSLog(@"ex6----%@",[NSThread currentThread]);
//        NSLog(@"ex7----%@",[NSThread currentThread]);
//        NSLog(@"ex8----%@",[NSThread currentThread]);
//
    }];
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //添加任务到队列
    [queue addOperations:@[opr1,opr2,opr3,opr4] waitUntilFinished:YES];
    [queue addOperationWithBlock:^{
        NSLog(@"________________%@",[NSThread currentThread]);
    }];
}

-(void)operate1{
    NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
}
-(void)operate2{
    NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
}
-(void)operate3{
    NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
}
-(void)operate4{
    NSLog(@"%s-------%@",__func__,[NSThread currentThread]);
}
//使用自定义类继承NSOperation实现
-(void)selfBuild{
    //创建自定义对象
    MJQOperation *opr1 = [[MJQOperation alloc] init];
    MJQOperation *opr2 = [[MJQOperation alloc] init];
    MJQOperation *opr3 = [[MJQOperation alloc] init];
    MJQOperation *opr4 = [[MJQOperation alloc] init];
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //添加操作到队列
    [queue addOperations:@[opr1,opr2,opr3,opr4] waitUntilFinished:YES];
}



-(void)test{
    //默认为并发队列（具备并发和串行两种属性）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //修改最大并发数属性即可将其变为串行队列
    //最大并发数：同一时间可以执行的任务个数
    queue.maxConcurrentOperationCount = 1;
    
    //封装操作
    NSBlockOperation *opr1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr5 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr6 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    NSBlockOperation *opr7 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%s ----- %@",__func__,[NSThread currentThread]);
    }];
    
    //将任务放进队列
    [queue addOperations:@[opr1,opr2,opr3,opr4,opr5,opr6,opr7] waitUntilFinished:YES];\
    
    /*
     当设置最大并发数为1时运行结果
     2018-03-18 19:49:26.148470+0800 iOS多线程-NSOperation[34252:5623399] -[ViewController test]_block_invoke ----- <NSThread: 0x60400027bc40>{number = 3, name = (null)}
     2018-03-18 19:49:26.148819+0800 iOS多线程-NSOperation[34252:5623401] -[ViewController test]_block_invoke_2 ----- <NSThread: 0x600000267040>{number = 4, name = (null)}
     2018-03-18 19:49:26.149021+0800 iOS多线程-NSOperation[34252:5623399] -[ViewController test]_block_invoke_3 ----- <NSThread: 0x60400027bc40>{number = 3, name = (null)}
     2018-03-18 19:49:26.149304+0800 iOS多线程-NSOperation[34252:5623399] -[ViewController test]_block_invoke_4 ----- <NSThread: 0x60400027bc40>{number = 3, name = (null)}
     2018-03-18 19:49:26.150844+0800 iOS多线程-NSOperation[34252:5623399] -[ViewController test]_block_invoke_5 ----- <NSThread: 0x60400027bc40>{number = 3, name = (null)}
     2018-03-18 19:49:26.151474+0800 iOS多线程-NSOperation[34252:5623401] -[ViewController test]_block_invoke_6 ----- <NSThread: 0x600000267040>{number = 4, name = (null)}
     2018-03-18 19:49:26.151833+0800 iOS多线程-NSOperation[34252:5623401] -[ViewController test]_block_invoke_7 ----- <NSThread: 0x600000267040>{number = 4, name = (null)}

     可看出任务是串行执行的
     */
    
    //注意：串行执行并不意味着只开一条线程
    //最大并发数 > 1:并发队列
    //最大并发数 == 1:串行队列
    //最大并发数 == 0:不执行任务
    //最大并发数 == -1（默认）: -1表示最大值  表示不受限制
    
    
}
@end
