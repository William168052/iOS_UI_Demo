//
//  ViewController.m
//  线程安全
//
//  Created by William on 2018/3/17.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//售票员A
@property (nonatomic,strong) NSThread *threadA;
//售票员B
@property (nonatomic,strong) NSThread *threadB;
//售票员C
@property (nonatomic,strong) NSThread *threadC;
//票数
@property (nonatomic,assign) NSInteger totalCount;

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
    //设置总票数
    self.totalCount = 100;
    //创建线程
    self.threadA = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    self.threadB = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    self.threadC = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    
    self.threadA.name = @"threadA";
    self.threadB.name = @"threadB";
    self.threadC.name = @"threadC";
    
    //启动线程
    [self.threadA start];
    [self.threadB start];
    [self.threadC start];
}

-(void)sellTicket{
    while (1) {
        //互斥锁
        @synchronized(self){
            if(self.totalCount > 0){
                for (int i = 0; i<1000000; i++) {
                    
                }
                
                self.totalCount--;
                NSLog(@"%@卖出去了一张票，还剩%zd张票",[NSThread currentThread].name,self.totalCount);
            }else{
                NSLog(@"卖完了");
                break;
            }
        }
        
    }
    
}


@end
