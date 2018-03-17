//
//  ViewController.m
//  图片下载
//
//  Created by William on 2018/3/17.
//  Copyright © 2018年 William. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //创建子线程下载图片
    [NSThread detachNewThreadSelector:@selector(downloadData) toTarget:self withObject:nil];
    
    
}

-(void)downloadData{
    //获取URL
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521273860057&di=faabf2e77cdded952d11bbcfa7b78d30&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014fc4554236ee0000019ae9140050.jpg"];
    
    //下载二进制数据
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    
    
    //将二进制数据转换为UIImage类型
    UIImage *img = [UIImage imageWithData:imgData];
    NSLog(@"%@",[NSThread currentThread]);
    //显示图片（回到主线程）
    [self.imageV performSelectorOnMainThread:@selector(setImage:) withObject:img waitUntilDone:YES];
}


@end
