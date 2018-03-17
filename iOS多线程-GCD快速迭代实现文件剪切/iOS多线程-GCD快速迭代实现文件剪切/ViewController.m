//
//  ViewController.m
//  iOS多线程-GCD快速迭代实现文件剪切
//
//  Created by William on 2018/3/17.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //拿到文件路径
    NSString *from = @"/Users/william/Documents/GitHub/iOS_UI_Demo/iOS多线程-GCD快速迭代实现文件剪切/test/from";
    //获得目标文件路径
    NSString *to = @"/Users/william/Documents/GitHub/iOS_UI_Demo/iOS多线程-GCD快速迭代实现文件剪切/test/to";
    //得到目录下所有文件
    NSArray *pathArr = [[NSFileManager defaultManager] subpathsAtPath:from];
    NSLog(@"%@",pathArr);
    //遍历所有文件
    //1、普通循环
    NSInteger count = pathArr.count;
//    for(int i = 0;i<count;i++){
//        //拼接文件全路径
//        NSString *fullPath = [from stringByAppendingPathComponent:pathArr[i]];
//        NSString *toFullPath = [to stringByAppendingPathComponent:pathArr[i]];
//        //剪切操作
//        [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
//    }
    
    //快速迭代
    dispatch_apply(count, dispatch_get_global_queue(0, 0), ^(size_t index){
        //拼接文件全路径
                NSString *fullPath = [from stringByAppendingPathComponent:pathArr[index]];
                NSString *toFullPath = [to stringByAppendingPathComponent:pathArr[index]];
        //剪切操作
                [[NSFileManager defaultManager] moveItemAtPath:fullPath toPath:toFullPath error:nil];
    });
    
}

@end
