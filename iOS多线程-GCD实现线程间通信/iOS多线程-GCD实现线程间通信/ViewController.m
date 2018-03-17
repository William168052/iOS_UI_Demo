//
//  ViewController.m
//  iOS多线程-GCD实现线程间通信
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
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建子线程下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载图片
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1521304039748&di=267b072a83c43d77f71fc5316fe0a94e&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014fc4554236ee0000019ae9140050.jpg"];
        NSData *imgData = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:imgData];
        //更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = img;
        });
    });
    
}

@end
